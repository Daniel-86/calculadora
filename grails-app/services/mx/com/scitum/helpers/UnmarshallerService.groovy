package mx.com.scitum.helpers

import grails.transaction.Transactional
import mx.com.scitum.Propiedad
import mx.com.scitum.Categoria
import mx.com.scitum.Concepto
import mx.com.scitum.ConceptoEspecial
import mx.com.scitum.Dependencia
import mx.com.scitum.Item

@Transactional
class UnmarshallerService {

    def getConcreteItem(data) {
        Item itemInstance = null
        if(data?.domainClass == 'Concepto')
            itemInstance = data.id? Concepto.get(data.id): Concepto.findByCustomId(data.customId)
        else if(data?.domainClass == 'ConceptoEspecial')
            itemInstance = data.id? ConceptoEspecial.get(data.id): ConceptoEspecial.findByCustomId(data.customId)
        else if(data?.domainClass == 'Categoria')
            itemInstance = data.id? Categoria.get(data.id): Categoria.findByCustomId(data.customId)
        else if(data?.domainClass == 'Propiedad')
            itemInstance = data.id? Propiedad.get(data.id): Propiedad.findByCustomId(data.customId)
        return itemInstance
    }

    def removeDependency(Item parent, Item dep) {

        deleteDependencies(dep)

        if(dep instanceof Concepto) {
            parent instanceof ConceptoEspecial? parent.removeFromConceptosE(dep) : parent.removeFromConceptos(dep)
        }
        else if(dep instanceof ConceptoEspecial) {
            parent instanceof Categoria? parent.removeFromComponentes(dep): println("no hago nada")
        }
        else if (dep instanceof Propiedad && parent instanceof ConceptoEspecial) {
            parent.removeFromPropiedades(dep)
        }
        parent?.save(flush: true, failOnError: true)

        if(!(dep instanceof Propiedad)) trimTree(dep)

        return true
    }

    private def deleteDependencies(Item item) {
        List<Dependencia> dependencies = Dependencia.findAllByItem(item)
        dependencies*.delete(flush: true)
        if(item instanceof ConceptoEspecial) {
            item.conceptosE.each { Item childConcept->
                deleteDependencies(childConcept)
            }
            item.propiedades.each { Item property->
                deleteDependencies(property)
            }
        }
        else if(item instanceof Categoria) {
            item.conceptos.each {Item childConcept->
                deleteDependencies(childConcept)
            }
            item.componentes.each {Item childComponent->
                deleteDependencies(childComponent)
            }
        }
    }

    private def trimTree(Item item) {
        if(item instanceof Concepto || item instanceof Propiedad)
            item.delete(flush: true)
        else if (item instanceof ConceptoEspecial) {
            List<Item> conceptos = item.conceptosE
            List<Propiedad> propiedades = item.propiedades
            item.conceptosE = []
//            item.propiedades = []
            conceptos.each { child->
                trimTree(child)
            }
            try {
                propiedades*.delete(flush: true)
            } catch (all) {
//                all.printStackTrace()
            }
            item.delete(flush: true)
        }
        else if (item instanceof Categoria) {
            List<Item> conceptos = item.conceptos
            List<Item> componentes = item.componentes
            item.conceptos = []
            item.componentes = []
            componentes.each {componente->
                trimTree(componente)
            }
            conceptos*.delete(flush: true)
            item.delete(flush: true)
        }

    }
}

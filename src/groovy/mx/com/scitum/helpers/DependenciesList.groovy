package mx.com.scitum.helpers

import mx.com.scitum.Factor
import mx.com.scitum.Item

/**
 * Created by daniel.jimenez on 24/07/2015.
 *
 * Agrega funcionalidad de manera dinamica a una lista de mx.com.scitum.Dependencia
 */
class DependenciesList {

//    static def requiredItems

    /**
     * Encuentra el elemento de la lista que coincide con todos o con la mayoría de las dependencias especificadas
     * @param lista La lista en la cual buscar
     * @param test Las dependencias por las que buscar
     * @return Un único elemento del tipo mx.com.scitum.Dependencia o nulo
     */
    static def bestTicketMatch(List lista, test) {
        lista.inject([:]) { found, current ->
            if(current instanceof Factor)
                return found
            def matched = current.dependencies.intersect(test)
            if( !(Item.findByCustomId('tipo_de_cliente').conceptos.any {matched.contains(it)}) )
                return found
            if(!found.current) {
                found.current = current
                found.matched = matched
                found.missing = current.dependencies - matched
                found.extra = test - matched
                return found
            }
//            print "\n\n${current.data} \tC\t $test \t=\t $matched\t\tmissing:${current.data - matched}\textra:${test - matched}"
            def matchedVals = matched?.size()
//            println "\t\t*$matchedVals*"
            if (matchedVals == current.dependencies.size()) {
                if(found.current) {
                    def currentExtra = test - matched
                    if((matchedVals == found.current.depemdencies.size() && currentExtra.size() < found.extra.size())
                            || (matchedVals > found.current.dependencies.size())) {
                        found.current = current
                        found.matched = matched
                        found.missing = current.dependencies - matched
                        found.extra = test - matched
                    }
                }
                else {
                    found.current = current
                    found.matched = matched
                    found.missing = current.dependencies - matched
                    found.extra = test - matched
                }
            }
//            else if (matchedVals > found?.current?.dependencies?.size()) {i
//                found.current = current
//                found.matched = matched
//                found.missing = current.dependencies - matched
//                found.extra = test - matched
//            }
            return found
        }
    }
}

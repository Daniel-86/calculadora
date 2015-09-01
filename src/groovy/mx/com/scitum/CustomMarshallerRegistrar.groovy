package mx.com.scitum

import grails.converters.JSON

class CustomMarshallerRegistrar {
    
    void registerMarshallers() {

		JSON.registerObjectMarshaller(mx.com.scitum.Concepto) {
			def map = [:]
			map['id'] = it?.id
			map['descripcion'] = it?.descripcion
			map['costo'] = it?.costo
			map['multiple'] = it?.multiple
			map['nodeType'] = it?.nodeType
			map['domainClass'] = 'Concepto'
//			map['categoria'] = it?.categoria
//			map['padre'] = it?.padre
			map['customId'] = it?.customId
			map['nombre'] = it?.nombre
			map['visible'] = it?.visible
			map['eligible'] = it?.eligible
			map['single'] = it?.single
//	    	map['toText'] = it?.toString()
			return map 
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Propiedad) {
			def map = [:]
			map['descripcion'] = it?.descripcion
			map['tipo'] = it?.customType?.toString()
			map['customId'] = it?.customId
			map['nombre'] = it?.nombre
			map['domainClass'] = 'Propiedad'
			map['visible'] = it?.visible
			map['eligible'] = it?.eligible
			map['single'] = it?.single
			map['options'] = it?.options?: []
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.ConceptoEspecial) {
			def map = [:]
			map['descripcion'] = it?.descripcion
			map['nodeType'] = it?.nodeType
//			map['categoria'] = it?.categoria
//			map['padre'] = it?.padre
			map['conceptos'] = it?.conceptosE?: []
			map['propiedades'] = it?.propiedades?: []
			map['customId'] = it?.customId
			map['nombre'] = it?.nombre
			map['domainClass'] = 'ConceptoEspecial'
			map['visible'] = it?.visible
			map['eligible'] = it?.eligible
			map['single'] = it?.single
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Categoria) {
			def map = [:]
			map['id'] = it?.id
			map['descripcion'] = it?.descripcion
			map['multiple'] = it?.multiple
			map['required'] = it?.required
			map['nodeType'] = it?.nodeType
			map['conceptos'] = it?.conceptos?: []
			map['componentes'] = it?.componentes?: []
			map['techSelected'] = [currentItem: null, propiedades: [], arr: [[[descripcion: '', selected: false]]]]
			map['customId'] = it?.customId
			map['nombre'] = it?.nombre
			map['domainClass'] = 'Categoria'
			map['visible'] = it?.visible
			map['eligible'] = it?.eligible
			map['single'] = it?.single
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Dependencia) {
			def map = [:]
			map.item = it?.item
			map.lowerLimit = it?.lowerLimit
			map.upperLimit = it?.upperLimit
			map.step = it?.step
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Factor) {
			def map = [:]
			map['id'] = it?.id
			map['factor'] = it?.factor
			map['dependencies'] = it?.dependencyDetail
			map['nombre'] = it?.nombre
			map['customId'] = it?.customId
			map['descripcion'] = it?.descripcion
			map['target'] = it?.target?.collect {t-> t.toString()}
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Ticket) {
			def map = [:]
			map['id'] = it?.id
			map['cc'] = it?.cc
			map['es'] = it?.es
			map['acs'] = it?.acs
			map['rq'] = it?.rq
			map['dependencies'] = it?.dependencyDetail
			map['nombre'] = it?.nombre
			map['customId'] = it?.customId
			map['descripcion'] = it?.descripcion
			return map
		}

//		JSON.registerObjectMarshaller(mx.com.scitum.Regla) {
//			def map = [:]
//			map['id'] = it?.id
//			map['nombre'] = it?.nombre
//			map['descripcion'] = it?.descripcion
//			map['dependencies'] = it?.dependencyDetail
//			return map
//		}
		 
	}

}
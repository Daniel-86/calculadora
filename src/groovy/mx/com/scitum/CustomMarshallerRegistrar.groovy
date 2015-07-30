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
//	    	map['toText'] = it?.toString()
			return map 
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Propiedad) {
			def map = [:]
			map['descripcion'] = it?.descripcion
			map['tipo'] = it?.tipo
			map['customId'] = it?.customId
			map['domainClass'] = 'Propiedad'
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.ConceptoEspecial) {
			def map = [:]
			map['descripcion'] = it?.descripcion
			map['nodeType'] = it?.nodeType
//			map['categoria'] = it?.categoria
//			map['padre'] = it?.padre
			map['conceptos'] = it?.conceptosE
			map['propiedades'] = it?.propiedades
			map['customId'] = it?.customId
			map['domainClass'] = 'ConceptoEspecial'
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Categoria) {
			def map = [:]
			map['id'] = it?.id
			map['descripcion'] = it?.descripcion
			map['multiple'] = it?.multiple
			map['required'] = it?.required
			map['nodeType'] = it?.nodeType
			map['conceptos'] = it?.conceptos
			map['componentes'] = it?.componentes
			map['techSelected'] = [currentItem: null, propiedades: [], arr: [[[descripcion: '', selected: false]]]]
//	    	map['toText'] = it?.toString()
			map['customId'] = it?.customId
			map['domainClass'] = 'Categoria'
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
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
			map['categoria'] = it?.categoria
			map['padre'] = it?.padre
			map['customId'] = it?.customId
//	    	map['toText'] = it?.toString()
			return map 
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Propiedad) {
			def map = [:]
			map['descripcion'] = it?.descripcion
			map['tipo'] = it?.tipo
			map['customId'] = it?.customId
			return map
		}

		JSON.registerObjectMarshaller(mx.com.scitum.ConceptoEspecial) {
			def map = [:]
			map['descripcion'] = it?.descripcion
			map['nodeType'] = it?.nodeType
			map['categoria'] = it?.categoria
			map['padre'] = it?.padre
			map['conceptos'] = it?.conceptosE
			map['propiedades'] = it?.propiedades
			map['customId'] = it?.customId
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
			return map 
		}

		 
	}

}
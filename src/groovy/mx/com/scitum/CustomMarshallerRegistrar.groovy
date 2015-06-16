package mx.com.scitum

import grails.converters.JSON

class CustomMarshallerRegistrar {
    
    void registerMarshallers() {

		JSON.registerObjectMarshaller(mx.com.scitum.Concepto) {
			def map = [:]
			map['id'] = it?.id
			map['descripcion'] = it?.descripcion
			map['costo'] = it?.costo
	    	map['toText'] = it?.toString()
			return map 
		}

		JSON.registerObjectMarshaller(mx.com.scitum.Categoria) {
			def map = [:]
			map['id'] = it?.id
			map['descripcion'] = it?.descripcion
			map['multiple'] = it?.multiple
			map['required'] = it?.required
	    	map['toText'] = it?.toString()
			return map 
		}

		 
	}

}
class UrlMappings {

	static mappings = {

        						'/concepto'(view: 'concepto')
		'/api/concepto'(resources: 'concepto')
'/categoria'(view: 'categoria')
		'/api/categoria'(resources: 'categoria')
'/concepto'(view: 'concepto')
		'/api/concepto'(resources: 'concepto')
"/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
	}
}

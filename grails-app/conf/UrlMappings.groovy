class UrlMappings {

    static mappings = {

        '/concepto'(view: 'concepto')
        '/api/concepto'(resources: 'concepto')
        '/categoria'(view: 'categoria')
        '/api/categoria'(resources: 'categoria')
        '/concepto'(view: 'concepto')
        '/api/concepto'(resources: 'concepto')
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:  "calculadora", action: "index")
        "/new-ticket" {
            view='/backoffice/create-ticket'
        }
//        "/new-factor" (view: '/backoffice/create-factor')
        "/edit-ticket/$id" {
            controller= 'backoffice'
            action= 'editTicket'
        }
        "/factor/$id?" {
            controller= 'backoffice'
            action= 'editFactor'
            constraints {
                id matches: /\d*/
            }
        }

        "/factores" view: '/backoffice/list-factor'
        "500"(view: '/error')
    }
}

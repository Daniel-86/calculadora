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
        "/factor/$id?" {
            controller= 'backoffice'
            action= 'editFactor'
            constraints {
                id matches: /\d*/
            }
        }
        "/ticket/$id?" {
            controller = 'backoffice'
            action = 'editTicket'
            constraints {
                id matches: /\d*/
            }
        }

        "/ticket/$id/delete" {
            controller = 'ticket'
            action = 'delete'
        }

        "/factores" view: '/backoffice/list-factor'
        "/tickets" view: '/backoffice/list-ticket'
        "500"(view: '/error')
    }
}

package mx.com.scitum

class CORSFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                response.setHeader "Access-Control-Allow-Origin", "*"
                response.setHeader "Access-Control-Allow-Headers", "Content-Type, x-xsrf-token"
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}

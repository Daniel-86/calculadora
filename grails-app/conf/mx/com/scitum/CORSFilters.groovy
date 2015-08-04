package mx.com.scitum

class CORSFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                response.setHeader "Access-Control-Allow-Origin", '*'
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}

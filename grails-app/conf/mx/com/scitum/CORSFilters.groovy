package mx.com.scitum

class CORSFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                response.setHeader "Access-Control-Allow-Origin", '*'
                response.setHeader "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept"
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}

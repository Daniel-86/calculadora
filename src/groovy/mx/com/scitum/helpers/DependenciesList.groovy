package mx.com.scitum.helpers

import mx.com.scitum.Factor

/**
 * Created by daniel.jimenez on 24/07/2015.
 *
 * Agrega funcionalidad, de manera dinamica, a una lista de mx.com.scitum.Dependencia
 */
class DependenciesList {

    /**
     * Encuentra el elemento de la lista que coincide con todos o con la mayoria de las dependencias especificadas
     * @param lista La lista en la cual buscar
     * @param test Las dependencias por las que buscar
     * @return Un único elemento del tipo mx.com.scitum.Dependencia
     */
    static def bestTicketMatch(List lista, test) {
        lista.inject([:]) { found, current ->
            if(current instanceof Factor)
                return found
            def matched = current.dependencies.intersect(test)
//            print "\n\n${current.data} \tC\t $test \t=\t $matched\t\tmissing:${current.data - matched}\textra:${test - matched}"
            def matchedVals = matched?.size()
//            println "\t\t*$matchedVals*"
            if (matchedVals == current.dependencies.size()) {
                found = current
//                found.matched = matched
//                found.missing = found.dependencies - matched
//                found.extra = test - matched
            } else if (matchedVals > found?.dependencies?.size()) {
                found = current
//                found.matched = matched
//                found.missing = found.dependencies - matched
//                found.extra = test - matched
            }
//            println "bestTicketMatch Dependencies ${current.dependencies}"
//            println "\tFOUND $found"
            return found
        }
    }
}

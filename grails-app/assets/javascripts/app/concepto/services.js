'use strict';

function ConceptoResource(CrudResourceFactory) {
    return CrudResourceFactory('/api/concepto', 'Concepto');
}

angular.module('app.concepto.services', ['grails'])
    .factory('ConceptoResource', ConceptoResource);

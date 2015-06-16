'use strict';

function CategoriaResource(CrudResourceFactory) {
    return CrudResourceFactory('/api/categoria', 'Categoria');
}

angular.module('app.categoria.services', ['grails'])
    .factory('CategoriaResource', CategoriaResource);

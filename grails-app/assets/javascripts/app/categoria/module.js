//= require_self 
//= require controllers
//= require services 
//= require_tree /app/categoria/templates/

'use strict';

angular.module('app.categoria', [
	'grails', 
	'app.categoria.controllers', 
	'app.categoria.services'
])
.value('defaultCrudResource', 'CategoriaResource')
.config(function($routeProvider) {
	$routeProvider
        .when('/', {
            controller: 'ListCtrl as ctrl',
            templateUrl: 'list.html',
            resolve: {
                categoriaList: function($route, CategoriaResource) {
                    var params = $route.current.params;
                    return CategoriaResource.list(params);
                } 
            }
        })
        .when('/create', {
            controller: 'CreateEditCtrl as ctrl',
            templateUrl: 'create-edit.html',
            resolve: {
                categoria: function(CategoriaResource) {
                    return CategoriaResource.create();
                } 
            }
        })
        .when('/edit/:id', {
            controller: 'CreateEditCtrl as ctrl',
            templateUrl: 'create-edit.html',
            resolve: {
                categoria: function($route, CategoriaResource) {
                    var id = $route.current.params.id;
                    return CategoriaResource.get(id);
                } 
            }
        })
        .when('/show/:id', {
            controller: 'ShowCtrl as ctrl',
            templateUrl: 'show.html',
            resolve: {
                categoria: function($route, CategoriaResource) {
                    var id = $route.current.params.id;
                    return CategoriaResource.get(id);
                }
            }
        })
        .otherwise({redirectTo: '/'});
});

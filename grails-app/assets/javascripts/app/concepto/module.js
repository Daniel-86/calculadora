//= require_self 
//= require controllers
//= require services 
//= require_tree /app/concepto/templates/

'use strict';

angular.module('app.concepto', [
	'grails', 
	'app.concepto.controllers', 
	'app.concepto.services'
])
.value('defaultCrudResource', 'ConceptoResource')
.config(function($routeProvider) {
	$routeProvider
        .when('/', {
            controller: 'ListCtrl as ctrl',
            templateUrl: 'list.html',
            resolve: {
                conceptoList: function($route, ConceptoResource) {
                    var params = $route.current.params;
                    return ConceptoResource.list(params);
                } 
            }
        })
        .when('/create', {
            controller: 'CreateEditCtrl as ctrl',
            templateUrl: 'create-edit.html',
            resolve: {
                concepto: function(ConceptoResource) {
                    return ConceptoResource.create();
                } 
            }
        })
        .when('/edit/:id', {
            controller: 'CreateEditCtrl as ctrl',
            templateUrl: 'create-edit.html',
            resolve: {
                concepto: function($route, ConceptoResource) {
                    var id = $route.current.params.id;
                    return ConceptoResource.get(id);
                } 
            }
        })
        .when('/show/:id', {
            controller: 'ShowCtrl as ctrl',
            templateUrl: 'show.html',
            resolve: {
                concepto: function($route, ConceptoResource) {
                    var id = $route.current.params.id;
                    return ConceptoResource.get(id);
                }
            }
        })
        .otherwise({redirectTo: '/'});
});

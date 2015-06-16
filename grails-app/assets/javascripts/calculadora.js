//= require_self
//= require /app/calculadora/controllers
//= require /app/calculadora/services
//= require_tree /app/calculadora/templates/

'use strict';

angular.module('calculadora', [
    'calculadora.controllers'
]);

//angular.module('calculadora', [
//    'grails',
//    'calculadora.controllers',
//    'calculadora.services'
//])
//.config(function($routeProvider) {
//    $routeProvider.when('/', {
//        controller: 'calcularCtrl as ctrl',
//        templateUrl: 'calcular.html'
//    });
//});
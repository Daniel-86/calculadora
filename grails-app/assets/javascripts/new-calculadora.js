//= require_self
//= require /app/new-calculadora/controllers
//= require /app/new-calculadora/services
//= require_tree /app/new-calculadora/templates/

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
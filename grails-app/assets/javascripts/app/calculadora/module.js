//= require_self
//= require controllers
//= require services
//= require_tree /app/calculadora/templates/

'use strict';

angular.module('calculadora', [
    'calculadora.controllers',
    'calculadora.services'
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
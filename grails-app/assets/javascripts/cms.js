//= require_self
//= require /app/cms/controllers
//= require /app/cms/services
//= require_tree /app/cms/templates/

'use strict';

angular.module('cms', [
    'cms.controllers'
]);

//angular.module('cms', [
//    'grails',
//    'cms.controllers',
//    'cms.services'
//])
//.config(function($routeProvider) {
//    $routeProvider.when('/', {
//        controller: 'cmsCtrl as ctrl',
//        templateUrl: 'cms.html'
//    });
//});
//= require_self

var calculadoraControllers = angular.module('calculadora.controllers', ['checklist-model', 'toggle-switch', 'ui.bootstrap']);

//var model = {
//    chosen: [],
//    resultados: null,
//    openedCategory: {}
//};

//function getCategoryList($http) {
//    var muted = false; if(!muted) console.log('\n');
//    $http.get('calculadora/list').success(function(data) { if(!muted) console.log('getCategoryList data', data);
//        model.categories = data.categories;
//    });
//}

//calculadoraControllers.run(function($http) {
//    var muted = false; if(!muted) console.log('\n');
//    $http.get('calculadora/list').success(function(data) { if(!muted) console.log('run getList-succes data', data);
//        model.categories = data.categories;
//    });
//});


function getIdentifier(item, propertyName) {
    if(!angular.isDefined(propertyName)) propertyName = 'customId';
    return angular.isObject(item) ? item[propertyName] : item;
}


function mainCtrl($scope, $http) {

    var model = {
        chosen: [],
        resultados: null,
        openedCategory: {}
    };
    function getCategoryList() {
        var muted = false; if(!muted) console.log('\n');
        $http.get('calculadora/list').success(function(data) { if(!muted) console.log('getCategoryList data', data);
            model.categories = data.categories; if(!muted) console.log('getCategoryList model', model);
            $scope.categories = model.categories;
            $scope.chosen = model.chosen;
            $scope.resultados = model.resultados;
            $scope.openedCategory = model.openedCategory;
        });
    }
    getCategoryList();


    var muted = false; if(!muted) console.log('\n');

    //$scope.categories = model.categories;
    //$scope.chosen = model.chosen;
    //$scope.resultados = model.resultados;
    //$scope.openedCategory = model.openedCategory;
    //$scope.model = model;
    if(!muted) console.log('mainCtrl model.categories', model.categories);
    if(!muted) console.log('mainCtrl scope.categories', $scope.categories);

    $scope.isEmpty = function(item) {
        var key = getIdentifier(item);
        return !$scope.chosen || !angular.isArray($scope.chosen) || !$scope.chosen[key];
    };

    $scope.toggleSelected = function(item, state) {
        var key = getIdentifier(item);
        var chosenItem = $scope.chosen[key];
        if(!state) chosenItem = undefined;
        else if(state && !angular.isArray(chosenItem)) chosenItem = [];
    };

    $scope.noMatches = function() {
        return true;
    };


    /**
     * Para el acordeon
     */
    $scope.oneAtATime = false;
}

calculadoraControllers.controller('CalculadoraMainCtrl', mainCtrl);
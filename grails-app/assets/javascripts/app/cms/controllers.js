//= require_self
//= require listas

angular.module('cms.controllers', ['listas']).controller('cmsCtrl', function($scope, $http) {
    var getAllData = function() {
        $http.get('list/.json').success(function(data){console.log(data);
            $scope.categories = data.categories;
            $scope.childrens = data.categories;
        });
    };
    getAllData();

    console.log('cms.controllers - childrens', $scope.categories);

    $scope.showChildren = function(item, property) {
        if(!property)
            property = ['componentes', 'conceptos'];
        var childrens = [];
        angular.forEach(property, function(prop) {
            childrens.push.apply(childrens, item[prop]);
        });
        //return childrens;
        $scope.childrens = childrens;
        if(!angular.isArray($scope.tree))
            $scope.tree = [];
        var brdcrmbIndx = $scope.tree.indexOf(item);
        if(brdcrmbIndx > -1)
            $scope.tree.splice(brdcrmbIndx+1, $scope.tree.length - brdcrmbIndx);
        else
            $scope.tree.push(item);
        $scope.selected = item;
    };

    $scope.resetView = function() {
        $scope.tree = [];
        $scope.childrens = $scope.categories;
    };

    $scope.goBackTill = function(item) {

    };

    $scope.showPropForm = function() {
        $scope.newProperty = true;
    };

    $scope.cancelProp = function() {
        $scope.newProperty = false;
        $scope.newProp = null;
    };

    $scope.addProp = function(item) {
        var newProp = {};
        console.log('newProp '+ $scope.newProp);
        console.log('newProp desc '+ $scope.newPropDescripcion);
        //newProp.descripcion = $scope.newProp.descripcion;
        //newProp.tipo = $scope.newProp.tipo;
        item.propiedades.push(newProp);
        $scope.newProp = null;
    };
});
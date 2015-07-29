//= require_self
//= require listas

angular.module('cms.controllers', ['listas']).controller('cmsCtrl', function($scope, $http) {
    var muted = false;
    if(!muted) console.log('\n');
    var getAllData = function() {
        var muted = false;
        if(!muted) console.log('\n');
        $http.get('calculadora/list/.json').success(function(data){
            if(!muted) console.log('getAllData data', data);
            $scope.categories = data.categories;
            $scope.childrens = data.categories;
        });
    };
    getAllData();

    if(!muted) console.log('cms.controllers - childrens', $scope.categories);

    $scope.showChildren = function(item, property) {
        var muted = false;
        if(!muted) console.log('\n');
        if(!muted) console.log('showChildren item', item);
        if(!property)
            property = ['componentes', 'conceptos'];
        if(!muted) console.log('showChildren property', property);
        var childrens = [];
        angular.forEach(property, function(prop) {
            childrens.push.apply(childrens, item[prop]);
        });
        if(!muted) console.log('showChildren children', childrens);
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
        if(!muted) console.log('showChildren scope.selected', $scope.selected);
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

    $scope.addItem = function() {
        var muted = false;
        if(!muted) console.log('\n');
        var newData = {item: $scope.selected, descripcion: $scope.descripcion};
        $http.post("calculadora/addItem", newData).success(function(data) {
            if(!muted) console.log('addItem data', data);
            $scope.categories = data.categories;
            $scope.childrens = data.children;
            console.log('adDItem - children', $scope.childrens);
            $scope.showChildren($scope.selected);
        });
    };
});
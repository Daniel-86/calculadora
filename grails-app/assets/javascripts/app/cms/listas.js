angular.module('listas', ['ui.bootstrap']).controller('listasCtrl', function($scope) {
    $scope.showChildren = function(item, property) {
        if(!property)
            property = ['componentes', 'conceptos'];
        var children = [];
        angular.forEach(property, function(prop) {
            children.push.apply(children, item[prop]);
        });
        //return children;
        $scope.children = children;
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
        $scope.children = $scope.categories;
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
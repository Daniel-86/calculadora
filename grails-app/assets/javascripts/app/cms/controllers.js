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
            if(angular.isDefined(item) && angular.isArray(item[prop])) childrens.push.apply(childrens, item[prop]);
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
        $scope.selected = undefined;
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
        var muted = false;
        if(!muted) console.log('\n');
        var newProp = {customId: $scope.newPropNombre, descripcion: $scope.newPropDescripcion, tipo: $scope.newPropTipo, parent: $scope.selected};
        if(!muted) console.log('newProp '+ newProp);

        $http.post("propiedad/save", newProp)
            .success(function(data) {
                item.propiedades.push(data);
                $scope.newProp = null;
            })
            .error(function(data) {

            });
    };

    $scope.dropProperty = function(item, parent) {
        var muted = false;
        if(!muted) console.log('\n');
        $http.delete("propiedad/delete", {data: item})
            .success(function(data) {
                if(!muted) console.log('dropProperty data', data);
            })
            .error(function(data, status) {
                if(!muted) console.log('dropProperty (ERROR) status ' + status + '  data ', data);
            });
    };

    $scope.addItem = function() {
        var muted = false;
        if(!muted) console.log('\n');
        var newData = {item: $scope.selected, descripcion: $scope.descripcion, customId: $scope.customId, domainType: $scope.domainType};
        $http.post("calculadora/addItem", newData).success(function(data) {
            if(!muted) console.log('addItem data', data);
            $scope.categories = data.categories;

            //$scope.showChildren($scope.selected);

            if(angular.isDefined($scope.selected)) {
                $scope.selected = data.newItem;
                var childrens = [];
                angular.forEach(['componentes', 'conceptos'], function(prop) {
                    if(angular.isDefined($scope.selected) && angular.isArray($scope.selected[prop])) childrens.push.apply(childrens, $scope.selected[prop]);
                });
                if(!muted) console.log('addItem children', childrens);
                $scope.childrens = childrens;
                var idxTree = findWithAttr($scope.tree, 'id', $scope.selected.id);
                $scope.tree[idxTree-1] = $scope.selected;
            }
            else {
                $scope.childrens = data.children;
            }
            if(!muted) console.log('adDItem - children', $scope.childrens);
            $scope.descripcion = '';
            $scope.customId = '';
            if(!muted) console.log('addItem scope', $scope);
            if(!muted) console.log('addItem newItemForm', $scope.newItemForm);
            if(angular.isDefined($scope.$$childHead.newItemForm)) $scope.$$childHead.newItemForm.$setPristine();
            else if(angular.isDefined($scope.newItemForm)) $scope.newItemForm.$setPristine();
            else {if(!muted) console.log('addItem NO PUEDE RESETAR FORM');}
        });
    };

    $scope.removeChild = function(idxChild) {
        var muted = false;
        if(!muted) console.log('\n');
        var item = $scope.childrens[idxChild];
        if(!muted) console.log('removeChild item', item);
        var delData = {item: item, parent: $scope.selected};
        if(!muted) console.log('removeChild delData', delData);

        $http.delete("calculadora/deleteItem", {data: delData})
            .success(function(data) {
                if(!muted) console.log('removeChild data', data);
                if(item) {
                    if($scope.selected) {
                        if (!muted) console.log('removeChild selected', $scope.selected);
                        var isA = 'unknown';
                        var parentIdx = findWithAttr($scope.tree, 'id', $scope.selected.id);
                        if (!muted) console.log('removeChild tree', $scope.tree);
                        if (!muted) console.log('removeChild parentIdx', parentIdx - 1);
                        var parent = $scope.tree[parentIdx - 1];
                        if (!muted) console.log('removeChild parent', parent);
                    }
                    var realIdx;
                    if(parent) {
                        if ((realIdx = findWithAttr(parent.componentes, 'customId', item.customId)) >= 0) {
                            isA = 'componentes'
                        }
                        else if ((realIdx = findWithAttr(parent.conceptos, 'customId', item.customId)) >= 0) {
                            isA = 'conceptos'
                        }
                        if (!muted) console.log('removeChild idxChild ' + idxChild + '  isA ' + isA + '  parentIdx ' + parentIdx - 1 + '   realIdx ' + realIdx - 1);
                        if (!muted) console.log('removeChild selected', $scope.selected[isA][realIdx - 1]);
                        $scope.selected[isA].splice(realIdx - 1, 1);
                        if (!muted) console.log('removeChild tree', $scope.tree[parentIdx - 1][isA][realIdx - 1]);
                        $scope.tree[parentIdx - 1][isA].splice(realIdx - 1, 1);
                    }
                    if(!muted) console.log('removeChild childrens', $scope.childrens[idxChild]);
                    $scope.childrens.splice(idxChild, 1);
                }
            });
    };
});
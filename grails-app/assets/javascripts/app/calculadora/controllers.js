//= require_self
//= require accordion

angular.module('calculadora.controllers', ['accordion']).controller('calcularCtrl', function($scope, $http) {
    var getAllData = function() {
        $http.get('list/.json').success(function(data){//console.log(data);
            $scope.categories = data;
        });
    };
    getAllData();

    //$scope.paquete = {};

    $scope.oneAtATime = true;

    $scope.groups = [
        {
            title: 'Dynamic Group Header - 1',
            content: 'Dynamic Group Body - 1'
        },
        {
            title: 'Dynamic Group Header - 2',
            content: 'Dynamic Group Body - 2'
        }
    ];

    $scope.items = ['Item 1', 'Item 2', 'Item 3'];

    $scope.addItem = function() {
        var newItemNo = $scope.items.length + 1;
        $scope.items.push('Item ' + newItemNo);
    };

    $scope.status = {
        isFirstOpen: true,
        isFirstDisabled: false
    };

    $scope.updateItems = function(category, item) {
        console.log(item);
        if(!category.selected)
            category.selected = [];
        if(item.selected)
            category.selected.push(item);
        else {
            var indx = category.selected.indexOf(item);
            category.selected.splice(indx, 1);
        }
    };

    $scope.showOptions = function(item) {
        console.log("componente: "+item);
        console.log('scope: '+item.asdf);
        $scope.shwOpts = true;
        //$scope.options = item.propiedades;
        $scope.options = item.asdf.propiedades;
    };
});
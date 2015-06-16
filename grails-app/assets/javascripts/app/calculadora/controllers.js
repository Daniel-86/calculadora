//= require_self
//= require accordion

angular.module('calculadora.controllers', ['accordion']).controller('calcularCtrl', function($scope, $http) {
    var getAllData = function() {
        $http.get('list/.json').success(function(data){//console.log(data);
            $scope.categories = data;
        });
    };
    getAllData();
});
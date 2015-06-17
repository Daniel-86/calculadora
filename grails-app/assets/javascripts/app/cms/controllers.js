//= require_self
//= require listas

angular.module('cms.controllers', ['listas']).controller('cmsCtrl', function($scope, $http) {
    var getAllData = function() {
        $http.get('list/.json').success(function(data){//console.log(data);
            $scope.categories = data;
        });
    };
    getAllData();
});
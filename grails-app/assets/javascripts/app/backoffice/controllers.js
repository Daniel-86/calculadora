//= require_self

angular.module('backoffice.controllers', []).controller('ticketCtrl', function($scope, $http) {
    function getAvailableDependencies() {
        $http.get('backoffice/listAvailableDependencies/.json').success(function(data){ console.log(data);
            $scope.available = data.available;
        });
    }
    getAvailableDependencies();

    $scope.isDirty = function() {
        var creaForma = $scope.createTForm;
        return creaForma.cc.$invalid || creaForma.es.$invalid || creaForma.acs.$invalid || creaForma.rq.$invalid;
    };

    $scope.createTicketAjax = function() {
        var ticketData = {};
        var dependencies = $scope.selected.map(function (obj) {
            return obj.customId;
        });
        console.log('createTicketAjax - dependencies',dependencies);
        ticketData['dependencias'] = dependencies;
        ticketData['cc'] = $scope.cc;
        ticketData['es'] = $scope.es;
        ticketData['acs'] = $scope.acs;
        ticketData['rq'] = $scope.rq;
        $http.post('/calculadora/ticket/save', ticketData).success(alert('creado'));
    };
});

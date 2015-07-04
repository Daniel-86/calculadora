//= require_self

angular.module('backoffice.controllers', [])

    .controller('ticketCtrl', function ($scope, $http) {
        function getAvailableDependencies() {
            $http.get('backoffice/listAvailableDependencies/.json').success(function (data) {
                console.log(data);
                $scope.available = data.available;
            });
        }

        getAvailableDependencies();

        $scope.isDirty = function () {
            var creaForma = $scope.createTForm;
            return creaForma.cc.$invalid || creaForma.es.$invalid || creaForma.acs.$invalid || creaForma.rq.$invalid;
        };

        $scope.createTicketAjax = function () {
            var ticketData = {};
            var dependencies = $scope.selected.map(function (obj) {
                return obj.customId;
            });
            console.log('createTicketAjax - dependencies', dependencies);
            ticketData['dependencias'] = dependencies;
            ticketData['cc'] = $scope.cc;
            ticketData['es'] = $scope.es;
            ticketData['acs'] = $scope.acs;
            ticketData['rq'] = $scope.rq;
            $http.post('/calculadora/ticket/save', ticketData).success(function (data) {
                alert('creado');
            });
        };
    })

    .controller('factorCtrl', function ($scope, $http) {
        function getAvailableDependencies() {
            $http.get('backoffice/listAvailableDependencies').success(function (data) {
                $scope.available = data.available;
            });
        }

        getAvailableDependencies();

        $scope.isDirty = function () {
            var creaForma = $scope.createForm;
            return creaForma.factor.$invalid || creaForma.lowerLimit.$invalid || creaForma.upperLimit.$invalid;
        };

        $scope.createFactorAjax = function () {
            var factorData = {};
            var factorDependencies = $scope.selected.map(function (obj) {
                return obj.customId;
            });
            console.log('createAjax - dependencies', factorDependencies);
            factorData['dependencias'] = factorDependencies;
            factorData['factor'] = $scope.factor;
            factorData['lowerLimit'] = $scope.lowerLimit;
            factorData['upperLimit'] = $scope.upperLimit;
            $http.post('/calculadora/factor/save', factorData)
                .success(function (data) {
                    console.log('nuevo factor creado');
                })
                .error(function (data, status, headers, config) {
                    console.log('error (' + status + '): ', data);
                    var creaForma = $scope.createForm;
                    var serverErrors = data.errors;
                    angular.forEach(serverErrors, function (error) {
                        var field = error.field;
                        var message = error.message;
                        var rejectedVal = error['rejected-value'];
                        if (!angular.isArray(creaForma[field].serverErrors)) creaForma[field].serverErrors = [];
                        creaForma[field].serverErrors.push(message);
                    });
                });
        };
    })

    .controller('editTicketCtrl', function ($scope, $http) {
        function getAvailableDependencies() {
            $http.get('/calculadora/ticket/editNG/' + ticketId).success(function (data) {
                console.log(data);
                $scope.available = data.available;
                $scope.ticket = data.ticket;
                $scope.selected = data.ticket.dependencias;
            });
        }

        getAvailableDependencies();

        $scope.isDirty = function () {
            var creaForma = $scope.createTForm;
            return creaForma.cc.$invalid || creaForma.es.$invalid || creaForma.acs.$invalid || creaForma.rq.$invalid;
        };

        $scope.createTicketAjax = function () {
            var ticketData = {};
            var dependencies = $scope.selected.map(function (obj) {
                return obj.customId;
            });
            console.log('createTicketAjax - dependencies', dependencies);
            ticketData['dependencias'] = dependencies;
            ticketData['cc'] = $scope.ticket.cc;
            ticketData['es'] = $scope.ticket.es;
            ticketData['acs'] = $scope.ticket.acs;
            ticketData['rq'] = $scope.ticket.rq;
            $http.post('/calculadora/ticket/update', ticketData)
                .success(function (data) {
                    alert('editado');
                }).error(function(data, status) {
                    console.log('error (' + status + '): ', data);
                    console.log(typeof status);
                    var creaForma = $scope.createTForm;
                    if(status === 402) {
                        var serverErrors = data.errors;
                        angular.forEach(serverErrors, function (error) {
                            var field = error.field;
                            var message = error.message;
                            var rejectedVal = error['rejected-value'];
                            if (!angular.isArray(creaForma[field].serverErrors)) creaForma[field].serverErrors = [];
                            creaForma[field].serverErrors.push(message);
                        });
                    }
                    if(status === 405) {console.log('createTicketAjax es 405');
                        creaForma.generalErrors = ['The specified HTTP method is not allowed for the requested' +
                            ' resource.'];
                    }

                });
        };
    });

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

        $scope.factor = {};
        $scope.factor.id = angular.isDefined(ticketId)? ticketId: null;
        console.log('factorCtrl ticketId', ticketId);

        function getAvailableDependencies() {
            var url = '/calculadora/factor/dependenciesData' + (ticketId > 0? '/'+ticketId: ''); console.log('factorCtrl' +
                ' url', url);
            $http.get(url).success(function (data) {console.log('factorCtrl data', data);
                $scope.available = data.available;
                $scope.factor = data.factor;
                if($scope.factor && $scope.factor.id > 0) $scope.selected = data.factor.dependencias;
            });
        }

        getAvailableDependencies();

        function getList() {
            $http.get('/calculadora/factor/list').success(function(data) {
                $scope.factorList = data;
            });
        }
        getList();

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
            factorData['factor'] = $scope.factor.factor;
            factorData['lowerLimit'] = $scope.factor.lowerLimit;
            factorData['upperLimit'] = $scope.factor.upperLimit;
            factorData['descripcion'] = $scope.factor.descripcion;
            factorData['id'] = $scope.factor.id;


            var url = ticketId > 0? '/calculadora/factor/update/'+ticketId: '/calculadora/factor/save';
            console.log('url '+url);
            console.log('factorData', factorData);
            function successAjax(data, status) {
                console.log('nuevo factor creado', data);
                var creaForma = $scope.createForm;
                if(status === 201 || status === 200) {
                    creaForma.generalInfo = ['El elemento con id '+data.id+' fue '+(status === 201? 'creado': 'actualizado')];
                }
            }
            function errorAjax(data, status, headers, config)  {
                $scope.createForm.generalInfo = [];
                angular.forEach($scope.createForm, function(item) {
                    item.serverErrors = [];
                });
                console.log('error (' + status + '): ', data);
                var creaForma = $scope.createForm;
                if(status === 402 || status === 422) {
                    var serverErrors = data.errors;
                    angular.forEach(serverErrors, function (error) {
                        var field = error.field;
                        var message = error.message; console.log('field, message ' + field + '   '+message);
                        var rejectedVal = error['rejected-value'];
                        if (!angular.isArray(creaForma[field].serverErrors)) creaForma[field].serverErrors = [];
                        creaForma[field].serverErrors.push(message);
                    });
                }
                if(status === 405) {console.log('createTicketAjax es 405');
                    creaForma.generalErrors = ['The specified HTTP method is not allowed for the requested' +
                    ' resource.'];
                }
                else {
                    creaForma.generalErrors = ["Se recibió un error "+status]
                }
            }

            if(ticketId > 0) {
                $http.put(url, factorData)
                    .success(successAjax)
                    .error(errorAjax);
            }
            else {
                $http.post(url, factorData)
                    .success(successAjax)
                    .error(errorAjax);
            }
        };
    })

    .controller('editTicketCtrl', function ($scope, $http) {
        $scope.ticket = {};
        $scope.ticket.id = ticketId;
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
            ticketData['id'] = $scope.ticket.id;
            $http.put('/calculadora/ticket/update', ticketData)
                .success(function (data) {
                    //alert('editado');
                    var creaForma = $scope.createTForm;
                    creaForma.generalInfo = ['Se actualizó el elemento con id '+data.id];
                }).error(function(data, status) {
                    console.log('error (' + status + '): ', data);
                    console.log(typeof status);
                    var creaForma = $scope.createTForm;
                    if(status === 402 || status === 422) {
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
                    else {
                        creaForma.generalErrors = ["Se recibió un error "+status]
                    }

                });
        };
    })



    .directive('dependsOn', function() {
        return {
            restrict: 'A',
            require: 'ngModel',
            link: function(scope, elem, attr, ctrl) {
                //scope.$watch(scope.lowerLimit, function(newVal, oldVal) {
                //    console.log('directive dependsOn attr: ', attr);
                //    console.log('directive dependsOn element: ', elem);
                //    console.log('directive dependsOn scope: ', scope);
                //    console.log('directive dependsOn ctrl: ', ctrl);
                //    if(newVal >= attr.dependsOn) {
                //        console.log('ES VALIDO');
                //    }else {
                //        console.log('ES INVALIDO');
                //    }
                //});

                ctrl.$parsers.unshift(function(value) {
                    //console.log('directive PARSER dependsOn val: ', attr.dependsOn);
                    //console.log('directive PARSER dependsOn element: ', elem);
                    //console.log('directive PARSER dependsOn scope: ', scope);
                    //console.log('directive PARSER dependsOn ctrl: ', ctrl);
                    var valid = false;
                    if(value && value >= attr.dependsOn) {
                        //console.log('ES VALIDO parser');
                        valid = true;
                    }else {
                        //console.log('ES INVALIDO parser');
                    }
                    ctrl.$setValidity('range', valid);
                    return valid? value: undefined;
                });
            }
        }
    });

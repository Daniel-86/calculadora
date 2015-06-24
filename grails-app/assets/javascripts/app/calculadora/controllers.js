//= require_self
//= require accordion

//angular.module('calculadora.controllers', ['checklist-model', 'accordion', 'frapontillo.bootstrap-switch'])
angular.module('calculadora.controllers', ['checklist-model', 'accordion', 'toggle-switch'])
    .controller('calcularCtrl', function ($scope, $http) {


        var getAllData = function () {
            $http.get('/calculadora/calculadora/list/.json').success(function (data) {//console.log(data);
                //$scope.categories = data;
                $scope.categories = data.categories;
                $scope.currentCatego = {
                    techSelected: {
                        currentItem: null,
                        propiedades: [],
                        arr: [
                            [
                                {selected:false,
                                    descripcion: ''}]]}};
            });
        };
        getAllData();


        function findWithAttr(array, attr, value) {
            if (angular.isArray(array)) {
                for (var i = 0; i < array.length; i++) {
                    if (array[i][attr] === value) {
                        return i;
                    }
                }
            }
        }

        function indexOfAll(array, value) {
            var indexArr = [];
            if (angular.isArray(array)) {
                for (var i = 0; i < array.length; i++) {
                    if (array[i] === value) indexArr.push(i);
                }
            }
            return indexArr;
        }

        $scope.paquete = [];
        $scope.currentCategory = '';
        $scope.currentCatego = {techSelected: {currentItem: null, propiedades: [], arr: []}};
        $scope.categoOpened = [true];
        $scope.techs = [];
        var techCategoIndx = findWithAttr($scope.categories, 'descripcion', 'Tecnología');

        //$scope.categoOpened = [false, false, true];
        //$scope.currentCatego = $scope.categories[2];

        $scope.$watchCollection('categoOpened', function (newV, oldV) {
            //console.log("entró watch categoOpened    oldV: "+oldV+"  newV: "+newV);
            var openedIndx = indexOfAll($scope.categoOpened, true);
            if (angular.isArray($scope.categories) && openedIndx.length > 0) {
                $scope.currentCatego = $scope.categories[openedIndx[0]];
            }
            //if(oldV === true && newV === false) {
            //    $scope.currentCatego = null;
            //}
            //if(oldV === false && newV === true) {
            //    $scope.currentCatego = $scope.categories[$scope.categoOpened.indexOf(true)];
            //}
        });


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

        $scope.addItem = function () {
            var newItemNo = $scope.items.length + 1;
            $scope.items.push('Item ' + newItemNo);
        };

        $scope.status = {
            isFirstOpen: true,
            isFirstDisabled: false
        };

        $scope.updateItems = function (category, item) {
            console.log(item);
            if (!category.selected)
                category.selected = [];
            if (item.selected)
                category.selected.push(item);
            else {
                var indx = category.selected.indexOf(item);
                category.selected.splice(indx, 1);
            }
        };

        $scope.newUpdateItems = function (arr, item, indx) {
            console.log('newUpdateItems - item: ', item);
            console.log('newUpdateItems - indx: ', indx);
            //console.log('newUpdateItems - parent: ', $scope.$parent);
            console.log('newUpdateItems - arr: ', arr[indx]);
            if (!arr[indx]) {
                arr[indx] = [];
                //$scope.techs[indx] = [];
                //$scope.$parent.currentCatego.techSelected.arr = [];
            }
            if (item.selected) {
                if(arr[indx].indexOf(item) < 0)
                    arr[indx].push(item);
                //$scope.techs[indx].push(item.descripcion);
                //$scope.$parent.currentCatego.techSelected.arr.push(item);
            }
            else {
                var iindx = arr[indx].indexOf(item);
                arr[indx].splice(iindx, 1);
                //$scope.techs[indx].splice(iindx,  1);
                //$scope.$parent.currentCatego.techSelected.arr.splice(iindx, 1);

            }
            $scope.currentCatego.techSelected.arr = arr;
            console.log("newUpdateItems - $scope: ",$scope);
        };

        $scope.showOptions = function (item) {
            //console.log("componente: "+item);
            //console.log('scope: '+item.current);
            //$scope.shwOpts = true;
            //$scope.techSelected = item.current;
            //item.currentArray = [];
            //$scope.options = item.propiedades;
            //console.log("showOptions - scope: ", $scope);
            //console.log("showOptions - scope.techSelected " + $scope.techSelected);
            //console.log("showOptions -scope.currentCatego.techSelected ", $scope.currentCatego.techSelected);
            //$scope.options = $scope.currentCatego.techSelected.propiedades;
        };

        $scope.lookForQuantity = function (current, prop) {
            if (prop.descripcion === 'cantidad') {
                current.nItems = prop.valor;
                console.log('nItems: ' + current.nItems);
                var basura = [];
                for (var i = 1; i <= current.nItems; i++) {
                    basura.push(i);
                }
                current.auxArray = basura;
                console.log('auxArray: ' + current.auxArray);
                if (!current.arr)
                    current.arr = [];
                if(current.arr.length > current.nItems) {
                    current.arr = current.arr.slice(0, current.nItems);
                }
                if(current.arr.length > 0) {
                    $scope.currentCatego.selected = true;
                } else {
                    //$scope.currentCatego.selected = false;
                    //angular.forEach($scope.currentCatego.componentes, function(tech) {
                    //    if(tech.arr && tech.arr.length > 0) {
                    //        $scope.currentCatego.selected = true;
                    //    }
                    //});
                    $scope.currentCatego.selected = $scope.currentCatego.componentes.some(function(element, idx, array) {
                        return (element.arr && element.arr.length > 0);
                    });
                    console.log('lookFor... - currentCatego', $scope.currentCatego);
                    //$scope.currentCatego.selected = $scope.currentCatego.componentes.each {it.arr &&}
                }
                if(!current.currentItem || current.currentItem > current.auxArray.length) {
                    current.currentItem = current.auxArray[0];
                }
            }
            if(!current.deviceScope) {
                current.deviceScope = 'todos';
            }
        };

        $scope.getQArray = function () {
            var asfd = new Array($scope.Q);
            console.log("select array: " + asfd);
            return new Array($scope.Q);
        };

        $scope.algo = function (item, conceptos, idx, arr) {
            //if (!item.arr[idx]) {
            //    item.arr[idx] = JSON.parse(JSON.stringify(item.conceptos));
            //    //$scope.currentCatego.techSelected.arr[$scope.currentCatego.techSelected.currentItem] = JSON.parse(JSON.stringify(item.conceptos));
            //    //item.arr[item.currentItem] = item.conceptos;
            //}
            //console.log('set current conceptos: ', item.arr[idx]);

            //if(!arr[idx-1]) {
            //    arr[idx-1] = JSON.parse(JSON.stringify(item.conceptos));
            //}
            //console.log('\n');
            //console.log('algo - conceptos: ', conceptos);
            //console.log('algo - idx: ', idx);
            //console.log('algo - arr: ', arr);
            //console.log('\n');


            //if(!item) {
            //    item = JSON.parse(JSON.stringify(conceptos));
            //}
        };

        $scope.currentDevice = function() {
            return $scope.currentCatego.techSelected.arr[$scope.currentCatego.techSelected.currentItem]
        };

        $scope.updateCatego = function(currentArr) {
            console.log('\n');
            console.log('updateCatego');

            var current = $scope.currentCatego.techSelected;

            console.log('updateCatego - current:', current);
            console.log('updateCatego - current.arr:', current.arr);
            console.log('updateCatego - currentArr:', currentArr);
            if(current.arr.length > 0) {console.log('updateCatego entró current.arr > 0');
                $scope.currentCatego.selected = true;
                console.log('updateCatego - arr > 0 currentCatego.selected', $scope.currentCatego.selected);
            } else {
                $scope.currentCatego.selected = $scope.currentCatego.componentes.some(function(element, idx, array) {
                    return (element.arr && element.arr.length > 0);
                });
                console.log('updateCatego - arr <= 0 currentCatego.selected', $scope.currentCatego.selected);
            }
            console.log('\n');
        };
        
        $scope.isOk = function(current) {
            console.log('\n');
            console.log('isOk');

            //var current = $scope.currentCatego.techSelected;
            var isOk = false;

            console.log('isOk - current:', current);
            console.log('isOk - current.arr:', current.arr);
            //console.log('isOk - currentArr:', currentArr);
            if(current.nItems > 0) {
                if(current.arr && current.arr.length > 0) {console.log('isOk entró current.arr > 0');
                    isOk = true;
                    console.log('isOk - arr > 0 currentCatego.selected', isOk);
                } else {
                    isOk = $scope.currentCatego.componentes.some(function(element, idx, array) {
                        return (element.arr && element.arr.length > 0);
                    });
                    console.log('isOk - arr <= 0 currentCatego.selected', isOk);
                }
            }
            console.log('\n');
            return isOk;
        };

        $scope.selectAll = function(o) {
            //angular.forEach(o.componentes, function(c) {
            //    c.selected = true;
            //});
            o.arr[o.currentItem-1] = o.conceptos;
            //console.log('selectAll - o.techSelected:', o);
            //console.log('selectAll - currentCatego.techSelected');
        };

        $scope.selectNone = function(o) {
            o.arr[o.currentItem-1] = [];
        };

        $scope.registerQuantity = function (current, prop) {
            if (prop.descripcion === 'cantidad') {
                current.nItems = prop.valor;
                console.log('nItems: ' + current.nItems);
                //var basura = [];
                //for (var i = 1; i <= current.nItems; i++) {
                //    basura.push(i);
                //}
                //current.auxArray = basura;
                //console.log('auxArray: ' + current.auxArray);
                if (!current.arr)
                    current.arr = [];
                if(current.arr.length > current.nItems) {
                    current.arr = current.arr.slice(0, current.nItems);
                }
                //if(current.arr.length > 0) {
                //    $scope.currentCatego.selected = true;
                //} else {
                //    //$scope.currentCatego.selected = false;
                //    //angular.forEach($scope.currentCatego.componentes, function(tech) {
                //    //    if(tech.arr && tech.arr.length > 0) {
                //    //        $scope.currentCatego.selected = true;
                //    //    }
                //    //});
                //    $scope.currentCatego.selected = $scope.currentCatego.componentes.some(function(element, idx, array) {
                //        return (element.arr && element.arr.length > 0);
                //    });
                //    console.log('lookFor... - currentCatego', $scope.currentCatego);
                //    //$scope.currentCatego.selected = $scope.currentCatego.componentes.each {it.arr &&}
                //}
                //if(!current.currentItem || current.currentItem > current.auxArray.length) {
                //    current.currentItem = current.auxArray[0];
                //}
            }
            //if(!current.deviceScope) {
            //    current.deviceScope = 'todos';
            //}
        };
    });

angular.module('calculadora.controllers')
    .filter('printString', function() {
        return function(input, prop) {
            if(angular.isArray(input)) {
                var descArray = input.map(function(o) {
                    return o[prop];
                });
                return descArray.join(', ');
            }
        }
    });
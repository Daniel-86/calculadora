//= require_self
//= require accordion

angular.module('calculadora.controllers', ['checklist-model', 'accordion'])
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
        $scope.categoOpened = [false, false, true];
        $scope.techs = [];
        var techCategoIndx = findWithAttr($scope.categories, 'descripcion', 'Tecnología');

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
            }
        };

        $scope.getQArray = function () {
            var asfd = new Array($scope.Q);
            console.log("select array: " + asfd);
            return new Array($scope.Q);
        };

        $scope.algo = function (item, conceptos, idx) {
            if (!item.arr[idx]) {
                item.arr[idx] = JSON.parse(JSON.stringify(item.conceptos));
                //$scope.currentCatego.techSelected.arr[$scope.currentCatego.techSelected.currentItem] = JSON.parse(JSON.stringify(item.conceptos));
                //item.arr[item.currentItem] = item.conceptos;
            }
            console.log('set current conceptos: ', item.arr[idx]);

            //if(!item) {
            //    item = JSON.parse(JSON.stringify(conceptos));
            //}
        };

        $scope.currentDevice = function() {
            return $scope.currentCatego.techSelected.arr[$scope.currentCatego.techSelected.currentItem]
        };
    });
//= require_self
//= require accordion

//angular.module('calculadora.controllers', ['checklist-model', 'accordion', 'frapontillo.bootstrap-switch'])
angular.module('calculadora.controllers', ['checklist-model', 'accordion', 'toggle-switch'])
    .controller('calcularCtrl', function ($scope, $http) {



        /**
         * Deep copy an object (make copies of all its object properties, sub-properties, etc.)
         * An improved version of http://keithdevens.com/weblog/archive/2007/Jun/07/javascript.clone
         * that doesn't break if the constructor has required parameters
         *
         * It also borrows some code from http://stackoverflow.com/a/11621004/560114
         */
        function deepCopy(src, /* INTERNAL */ _visited) {
            if(src == null || typeof(src) !== 'object'){
                return src;
            }

            // Initialize the visited objects array if needed
            // This is used to detect cyclic references
            if (_visited == undefined){
                _visited = [];
            }
            // Otherwise, ensure src has not already been visited
            else {
                var i, len = _visited.length;
                for (i = 0; i < len; i++) {
                    // If src was already visited, don't try to copy it, just return the reference
                    if (src === _visited[i]) {
                        return src;
                    }
                }
            }

            // Add this object to the visited array
            _visited.push(src);

            //Honor native/custom clone methods
            if(typeof src.clone == 'function'){
                return src.clone(true);
            }

            //Special cases:
            //Array
            if (Object.prototype.toString.call(src) == '[object Array]') {
                //[].slice(0) would soft clone
                ret = src.slice();
                var i = ret.length;
                while (i--){
                    ret[i] = deepCopy(ret[i], _visited);
                }
                return ret;
            }
            //Date
            if (src instanceof Date){
                return new Date(src.getTime());
            }
            //RegExp
            if(src instanceof RegExp){
                return new RegExp(src);
            }
            //DOM Elements
            if(src.nodeType && typeof src.cloneNode == 'function'){
                return src.cloneNode(true);
            }

            //If we've reached here, we have a regular object, array, or function

            //make sure the returned object has the same prototype as the original
            var proto = (Object.getPrototypeOf ? Object.getPrototypeOf(src): src.__proto__);
            if (!proto) {
                proto = src.constructor.prototype; //this line would probably only be reached by very old browsers
            }
            var ret = object_create(proto);

            for(var key in src){
                //Note: this does NOT preserve ES5 property attributes like 'writable', 'enumerable', etc.
                //For an example of how this could be modified to do so, see the singleMixin() function
                ret[key] = deepCopy(src[key], _visited);
            }
            return ret;
        }

//If Object.create isn't already defined, we just do the simple shim, without the second argument,
//since that's all we need here
        var object_create = Object.create;
        if (typeof object_create !== 'function') {
            object_create = function(o) {
                function F() {}
                F.prototype = o;
                return new F();
            };
        }




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
            var muted = true;
            if(!muted) console.log('\t\t\tfindWithAttr - array', array);
            if(!muted) console.log('\t\t\tfindWithAttr - attr', attr);
            if(!muted) console.log('\t\t\tfindWithAttr - value', value);
            if (angular.isArray(array)) {
                for (var i = 0; i < array.length; i++) {
                    if(!muted) console.log('\t\t\t\tfindWithAttr - array['+i+']['+attr+']', array[i][attr]);
                    if (array[i][attr] === value) {
                        return i+1;
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
        //$scope.status = {isFirstDisabled: false};

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
            var muted = true;
            if(!muted) console.log("\n");
            if (prop.descripcion === 'cantidad') {
                current.nItems = prop.valor;
                if(!muted) console.log('lookFor... - nItems: ' + current.nItems);
                var basura = [];
                for (var i = 1; i <= current.nItems; i++) {
                    basura.push(i);
                }
                current.auxArray = basura;
                if(!muted) console.log('lookFor.. - auxArray: ' + current.auxArray);
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
                    if(!muted) console.log('lookFor... - currentCatego', $scope.currentCatego);
                    //$scope.currentCatego.selected = $scope.currentCatego.componentes.each {it.arr &&}
                }
                if(!current.currentItem || current.currentItem > current.auxArray.length) {
                    current.currentItem = current.auxArray[0];
                }
            }
            if(!current.deviceScope) {
                current.deviceScope = 'todos';
            }
            if(!muted) console.log("\n");
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
            var muted = true;
            if(!muted) console.log('\n');
            if(!muted) console.log('updateCatego  itemArray=techSelected.arr  ItemValu=techSelected.tempArr');

            if(!muted) console.log('updateCatego - scope.tempArr', $scope.currentCatego.techSelected.tempArr);

            var current = $scope.currentCatego.techSelected;
            var nItems = $scope.currentCatego.techSelected.propiedades[0].valor;
            var customScope = $scope.currentCatego.techSelected.deviceScope;
            var itemArray = $scope.currentCatego.techSelected.arr;
            var itemValue = $scope.currentCatego.techSelected.tempArr;

            if(!muted) console.log('updateCatego - itemValue ', itemValue);

            if(nItems < 1) {
                return;
            }

            if(customScope === 'todos') {
                //if(!angular.isArray(itemArray))
                //    itemArray = [];
                if(!muted) console.log('updateCatego - todos: nItems ', nItems);
                itemArray = [];
                for(var i=0; i < nItems; i++) {
                    itemArray[i] = deepCopy(itemValue);
                    //itemArray.push(deepCopy(itemValue));
                    //itemArray.push(JSON.parse(JSON.stringify(itemValue)));
                    //itemArray.push(itemValue);
                }
                current.tempArr = itemArray;
            }
            if(customScope === 'uno') {
                if(!angular.isArray(itemArray))
                    itemArray = [];
                var currentIndx = $scope.currentCatego.techSelected.currentItem;
                if(!muted) console.log('updateCatego - uno: currentIndx ', currentIndx);
                itemArray[currentIndx-1] = deepCopy(itemValue);
                //itemArray[currentIndx-1] = JSON.parse(JSON.stringify(itemValue));
                //itemArray[currentIndx - 1] = itemValue;
            }
            if(customScope === 'varios') {
                var lowerL = $scope.currentCatego.techSelected.lowerLimit;
                var upperL = $scope.currentCatego.techSelected.upperLimit;
                if(!muted) console.log('updateCatego - varios: lowerL, upperL ', lowerL, upperL);
                if(!angular.isArray(itemArray))
                    itemArray = [];
                for(var j=lowerL; j<upperL; j++) {
                    itemArray[j] = deepCopy(itemValue);
                    //itemArray[j] = JSON.parse(JSON.stringify(itemValue));
                    //itemArray[j] = itemValue;
                }
                current.tempArr = itemArray;
            }
            if(!muted) console.log('updateCatego - itemArray ', itemArray);

            //if(!muted) console.log('updateCatego - current:', current);
            current.arr = itemArray;
            current.tempArr = itemValue;
            if(!muted) console.log('updateCatego - itemValue *AFTER*', itemValue);
            if(!muted) console.log('updateCatego - current.arr:', current.arr);
            if(!muted) console.log('updateCatego - currentArr:', currentArr);
            if(current.arr.length > 0) {if(!muted) console.log('updateCatego entró current.arr > 0');
                $scope.currentCatego.selected = true;
                if(!muted) console.log('updateCatego - arr > 0 currentCatego.selected', $scope.currentCatego.selected);
            } else {
                $scope.currentCatego.selected = $scope.currentCatego.componentes.some(function(element, idx, array) {
                    return (element.arr && element.arr.length > 0);
                });
                if(!muted) console.log('updateCatego - arr <= 0 currentCatego.selected', $scope.currentCatego.selected);
            }
            if(!muted) console.log('\n');
        };
        
        $scope.isOk = function(current) {
            var muted = true;
            if(!muted) console.log('\n');
            if(!muted) console.log('isOk');

            //var current = $scope.currentCatego.techSelected;
            var isOk = false;

            if(!muted) console.log('isOk - current:', current);
            if(!muted) console.log('isOk - current.arr:', current.arr);
            //console.log('isOk - currentArr:', currentArr);
            if(current.nItems > 0) {
                if(current.arr && current.arr.length > 0) {if(!muted) console.log('isOk entró current.arr > 0');
                    isOk = true;
                    if(!muted) console.log('isOk - arr > 0 currentCatego.selected', isOk);
                } else {
                    isOk = $scope.currentCatego.componentes.some(function(element, idx, array) {
                        return (element.arr && element.arr.length > 0);
                    });
                    if(!muted) console.log('isOk - arr <= 0 currentCatego.selected', isOk);
                }
            }
            if(!muted) console.log('\n');
            return isOk;
        };

        $scope.selectAll = function(o) {
            //angular.forEach(o.componentes, function(c) {
            //    c.selected = true;
            //});
            //var customScope = $scope.currentCatego.techSelected.deviceScope;
            $scope.currentCatego.techSelected.tempArr = o.conceptos;
            $scope.updateCatego([]);
            //o.arr[o.currentItem-1] = o.conceptos;
            //console.log('selectAll - o.techSelected:', o);
            //console.log('selectAll - currentCatego.techSelected');
        };

        $scope.selectNone = function(o) {
            //o.arr[o.currentItem-1] = [];
            $scope.currentCatego.techSelected.tempArr = [];
            $scope.updateCatego([]);
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

        $scope.updateOpened = function(catego, elem, $event) {
            if(!catego.selected) {
                elem = false;
                //console.log('updateOpened - elem ', elem);
                $scope.categoOpened[1] = false;
            }
            //console.log('updateOpened - scope.categoOpened ', $scope.categoOpened);
            $event.stopPropagation();
        };

        function getMinAvlbl() {
            return 0;
        }

        $scope.isRangeSelected = function() {
            var muted = true;
            if($scope.currentCatego.techSelected.deviceScope === 'todos') {
                $scope.currentCatego.techSelected.lowerLimit = 0;
                $scope.currentCatego.techSelected.upperLimit = $scope.currentCatego.techSelected.propiedades[0].valor;
                $scope.currentCatego.techSelected.currentItem = 0;
                if(!muted) console.log('isRangeSelected - todos: limits '+$scope.currentCatego.techSelected.lowerLimit+', '+$scope.currentCatego.techSelected.upperLimit);
                return true;
            }
            if($scope.currentCatego.techSelected.deviceScope === 'uno') {
                if($scope.currentCatego.techSelected.currentItem) {
                    $scope.currentCatego.techSelected.lowerLimit = $scope.currentCatego.techSelected.currentItem;
                    $scope.currentCatego.techSelected.upperLimit = $scope.currentCatego.techSelected.currentItem;
                    if(!muted) console.log('isRangeSelected - uno: limits '+$scope.currentCatego.techSelected.lowerLimit+', '+$scope.currentCatego.techSelected.upperLimit);
                    return $scope.currentCatego.techSelected.currentItem;
                }
                if(!muted) console.log('isRangeSelected - uno FAILED');
                return false;
            }
            if($scope.currentCatego.techSelected.deviceScope === 'varios') {
                if($scope.currentCatego.techSelected.range > 0) {
                    var minAvlbl = getMinAvlbl();
                    if(minAvlbl+$scope.currentCatego.techSelected.range > $scope.currentCatego.techSelected.propiedades[0].valor) { if(!muted) console.log('isRangeSelected varios FAILED');
                        return false;
                    }
                    $scope.currentCatego.techSelected.lowerLimit = minAvlbl;
                    $scope.currentCatego.techSelected.upperLimit = minAvlbl + $scope.currentCatego.techSelected.range;
                    $scope.currentCatego.techSelected.currentItem = 0;
                    if(!muted) console.log('isRangeSelected - varios: limits '+$scope.currentCatego.techSelected.lowerLimit+', '+$scope.currentCatego.techSelected.upperLimit);
                    return true;
                }
            }
        };

        $scope.updateTempArr = function() {
            var muted = true;
            if(!muted) console.log('\n');
            var tech = $scope.currentCatego.techSelected;
            var customScope = $scope.currentCatego.techSelected.deviceScope;
            var itemArray = $scope.currentCatego.techSelected.arr;
            var tempArray = $scope.currentCatego.techSelected.tempArr;
            tempArray = [];

            if(!angular.isArray(itemArray))
                return;
            if(!muted) console.log('updateTempArr - itemArray', itemArray);
            if(customScope === 'uno') {
                var currentIndx = $scope.currentCatego.techSelected.currentItem;
                tempArray = itemArray[currentIndx-1];
                if(!muted) console.log('updateTempArr - UNO***********');
                if(!muted) console.log('updateTempArr - currentIndx', currentIndx);
                if(!muted) console.log('updateTempArr - itemArray['+(+currentIndx-1)+']', itemArray[currentIndx-1]);
            }
            if(customScope === 'todos') {
                var referenceArray = itemArray[0];
                var nItems = $scope.currentCatego.techSelected.propiedades[0].valor;
                var commonProps = [];
                if(!muted) console.log('updateTempArr - referenceArray', referenceArray);
                for(var itemIndx in referenceArray) {
                    var itemReference = referenceArray[itemIndx];
                    if(!muted) console.log('\tupdateTempArr - itemReference', itemReference);
                    var value = itemReference['descripcion'];
                    if(!muted) console.log('\tupdateTempArr - value', value);
                    if(!muted) console.log('\tupdateTempArr - itemArray', itemArray);
                    var isEveryWhere = itemArray.every(function(element, index, array) {
                        if(!muted) console.log('\t\tupdateTempArr - element', element);
                        return findWithAttr(element, 'descripcion', value);
                        //return element['descripcion'] === value;
                        //return element.hasOwnProperty(itemIndx) && element[itemIndx] === value;
                    });
                    if(isEveryWhere) {
                        commonProps.push(itemReference);
                    }
                }
                var auxArray = [];
                for(var i=0; i < nItems; i++) {
                    auxArray[i] = deepCopy(commonProps);
                }
                //tempArray = auxArray;
                tempArray = deepCopy(commonProps);
                if(!muted) console.log('updateTempArr - TODOS *******************');
                if(!muted) console.log('updateTempArr - nItems', nItems);
                if(!muted) console.log('updateTempArr - commonProps', commonProps);
            }
            if(customScope === 'varios') {
                var lL = $scope.currentCatego.techSelected.lowerLimit;
                var uL = $scope.currentCatego.techSelected.upperLimit;
                var referenceArrayV = itemArray[lL];
                var commonPropsV = [];
                for(var itemIndxV in referenceArrayV) {

                    var itemReferenceV = referenceArrayV[itemIndxV];
                    //if(!muted) console.log('\tupdateTempArr - itemReference', itemReference);
                    var valueV = itemReferenceV['descripcion'];
                    //if(!muted) console.log('\tupdateTempArr - value', value);
                    //if(!muted) console.log('\tupdateTempArr - itemArray', itemArray);
                    var isEveryWhereV = itemArray.every(function(element, index, array) {
                        //if(!muted) console.log('\t\tupdateTempArr - element', element);
                        return findWithAttr(element, 'descripcion', value);
                        //return element['descripcion'] === value;
                        //return element.hasOwnProperty(itemIndx) && element[itemIndx] === value;
                    });
                    if(isEveryWhereV) {
                        commonPropsV.push(itemReferenceV);
                    }


                    //if(referenceObjectV.hasOwnProperty(itemIndxV)) {
                    //    var valueV = referenceObjectV[itemIndxV];
                    //    var isEveryWhereV = itemArray.every(function(element, index, array) {
                    //        return element.hasOwnProperty(itemIndxV) && element[itemIndxV] === valueV;
                    //    });
                    //    if(isEveryWhereV) {
                    //        commonPropsV[itemIndxV] = valueV;
                    //    }
                    //}
                }
                var auxArrayV = [];
                for(var iV=0; iV < uL; iV++) {
                    auxArrayV[iV] = deepCopy(commonPropsV);
                }
                //tempArray = auxArrayV;
                tempArray = deepCopy(commonPropsV);
                if(!muted) console.log('updateTempArr - VARIOS ***************');
                if(!muted) console.log('updateTempArr - lower, upper', lL, uL);
                if(!muted) console.log('updateTempArr - commonProps', commonPropsV);
            }
            tech.tempArr = tempArray;
            if(!muted) console.log('updateTempArr - tempArr', tempArray);
            if(!muted) console.log('updateTempArr - scope:tempArr', $scope.currentCatego.techSelected.tempArr);
            if(!muted) console.log('updateTempArr - scope:arr', $scope.currentCatego.techSelected.arr);
            if(!muted) console.log('\n');
        };


        $scope.calcular = function () {
            var muted = true;
            if(!muted) console.log('\n');
            var requestData = [];
            var categoKey;
            var categoVal;
            var volumetArr = {};
            for(var i=0; i<$scope.categories.length; i++) {
                var category = $scope.categories[i];
                var categoData = {};
                categoKey = category.customId;
                if(category.descripcion === 'Tipo de cliente') {
                    categoVal = category.selected.customId;
                    categoData[categoKey] = categoVal;
                }
                if(category.descripcion === 'Ingeniería en sitio' && category.selected) {
                    if(!muted) console.log('calcular - category', category);
                    var componentes = category.componentes;
                    categoVal = {};
                    for(var compoIndx=0; compoIndx<componentes.length; compoIndx++) {
                        if(!muted) console.log('calcular - componente', componentes[compoIndx]);
                        //var compoKey = componentes[compoIndx].customId;
                        var compoKey = componentes[compoIndx].propiedades[0].customId;
                        var compoValue = componentes[compoIndx].propiedades[0].valor;
                        if(!muted) console.log('calcular - compoKey', compoKey);
                        if(!muted) console.log('calcular - compoValue', compoValue);
                        if(compoValue > 0) {
                            categoVal[compoKey] = compoValue;
                            categoData[categoKey] = categoVal;
                        }
                    }
                    if(!muted) console.log('calcular - categoData', categoData);
                }
                if(category.descripcion === 'Tecnología') {
                    var compos = category.componentes;
                    categoVal = [];
                    var volumet = null;
                    if(compos.some(function(elem, idx, arr) {
                            return angular.isArray(elem.arr) && elem.arr.length > 0;
                        })) {
                        for(var iaux=0; iaux<compos.length; iaux++) {
                            if(angular.isArray(compos[iaux].arr) && compos[iaux].arr.length > 0) {
                                volumet = compos[iaux].propiedades[1].valor;
                            }
                        }
                    }
                    //var volumet = compos[0].arr.length > 0? compos[0].propiedades[1].valor: null;
                    if(!muted && compos[0].arr) console.log('calcular - arr.length', compos[0].arr.length);
                    if(!muted) console.log('calcular - volumet', compos[0].propiedades[1].valor);
                    for(var techIndx=0; techIndx<compos.length; techIndx++) {
                        var tech = compos[techIndx];
                        if(!muted) console.log('calcular - propiedades', tech.propiedades);
                        if(angular.isArray(tech.arr) && tech.arr.length > 0) {
                            var devices = tech.arr;
                            var techKey = tech.customId;
                            var techVal = [];
                            for(var deviceIndx=0; deviceIndx<devices.length; deviceIndx++) {
                                var device = devices[deviceIndx];
                                var deviceArr = [];
                                deviceArr = device.map(function(v) {
                                    return v['customId'];
                                });
                                techVal.push(deviceArr);
                            }
                            var basura = {};
                            basura[techKey] = techVal;
                            categoVal.push(basura);
                        }
                    }
                    categoData[categoKey] = categoVal;
                    volumetArr['volumetria'] = volumet;
                    if(!muted) console.log('calcular - volumetArr', volumetArr);
                    requestData.push(volumetArr);
                    if(!muted) console.log('calcular - requestData', requestData);
                }
                requestData.push(categoData);
            }
            if(!muted) console.log('\n');

            calcularAjax(requestData);
        };


        function calcularAjax(postData) {
            var muted = false;
            if(!muted) console.log('\n');
            $http.post('/calculadora/calculadora/calcular/.json', {"postData": postData}).success(function(data) {
                $scope.resultados = data;
                if(!muted) console.log('calcularAjax data',data);
                //$scope.resultados = data[0];
            });
        }

        $scope.noMatches = function() {
            var muted = true;
            if(!muted) console.log('\n');
            if(!muted) console.log('noMatches es array', angular.isArray($scope.resultados));
            if(angular.isArray($scope.resultados))
                if(!muted) console.log('noMatches es vacio', $scope.resultados.length == 0);
            return (angular.isArray($scope.resultados) && $scope.resultados.length == 0);

        };

        $scope.isReady = function() {
            var muted = true;
            if(!muted) console.log('\n');
            var hasErrors = false;
            var hasBeenSelected = false;
            angular.forEach($scope.categories, function(catego){
                if(catego.descripcion === 'Tipo de cliente') {if(!muted) console.log('isReady - tipoCliente.selected', catego.selected);
                    if(!catego.selected) {if(!muted) console.log('\tisReady - tipoCliente HAS_ERRORS');
                        hasErrors = true;
                        return hasErrors;
                    }
                }
                if(catego.descripcion === 'Ingeniería en sitio' && catego.selected) {if(!muted) console.log('isReady' +
                    ' - ingenieriaSitio.selected', catego.selected);
                    hasBeenSelected = catego.componentes.some(function(elem, idx, arr) {
                        return angular.isDefined(elem.nItems) && elem.nItems > 0;
                    });
                    if(!hasBeenSelected) {if(!muted) console.log('isReady - ingenieriaSitio.selected NO HAY CANTIDAD' +
                        ' PARA NINGUN RECURSO');
                        hasErrors = true;
                        return hasErrors;
                    }
                    //angular.forEach(catego.componentes, function(resource){if(!muted) console.log('\tisReady -' +
                    //    ' empleado', resource);
                    //    if(!(resource.propiedades[0].valor > 0)) {if(!muted) console.log('\t\tisReady -' +
                    //        ' ingenieriaSitio' +
                    //        ' HAS_ERRORS');
                    //        hasErrors = true;
                    //        return hasErrors;
                    //    }
                    //});
                }
                if(catego.descripcion === 'Tecnología') {if(!muted) console.log('isReady -' +
                    ' tecnologia.selected', catego.selected);
                    hasBeenSelected = catego.componentes.some(function(elem, idx, arr) {
                        return angular.isDefined(elem.nItems) && elem.nItems > 0;
                    });
                    if(!hasBeenSelected) {if(!muted) console.log('isReady - tecnologia NOHAY CANTIDAD PARA NINGUNA' +
                        ' TECNO');
                        hasErrors = true;
                        return hasErrors;
                    }
                    angular.forEach(catego.componentes, function(tech){if(!muted) console.log('\tisReady -' +
                        ' tech', tech);
                        if(tech.nItems > 0) {
                            if(!tech.propiedades[1].valor) {if(!muted) console.log('\t\tisReady - tecnologia' +
                                ' HAS_ERRORS  no hay volumetria seleccionada');
                                hasErrors = true;
                                return hasErrors;
                            }
                            if(!angular.isArray(tech.arr) || !(tech.arr.length > 0)) {if(!muted) console.log('\t\tisReady - tecnologia HAS_ERRORS');
                                hasErrors = true;
                                return hasErrors;
                            }
                            angular.forEach(tech.arr, function(item){if(!muted) console.log('\t\tisReady - tecnologia' +
                                ' item' +
                                ' ', item);
                                if(!angular.isArray(item) || !(item.length > 0)) {if(!muted) console.log('\t\t\tisReady' +
                                    ' - tecnologia HAS_ERRORS');
                                    hasErrors = true;
                                    return hasErrors;
                                }
                            });
                        }
                    });
                }
            });
            if(!muted) console.log('*****isReady hasErrors', hasErrors);
            return hasErrors;
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
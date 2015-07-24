<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 15/06/2015
  Time: 02:25 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-layout">
    <asset:javascript src="angular/angular.js"/>
    <asset:javascript src="angular/modules/checklist-model.js"/>
    %{--<asset:javascript src="bootstrap-switch.js"/>--}%
    %{--<asset:javascript src="angular/modules/angular-bootstrap-switch.ja"/>--}%
    <asset:javascript src="angular/modules/angular-toggle-switch.min.js"/>
    <asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>
    <asset:javascript src="calculadora.js"/>

    <asset:stylesheet src="angular-toggle-switch.css"/>

    <style>
    .descRow {
        margin-bottom: 6px;
    }

    .descMultiRow {
        margin-bottom: 0;
    }

    .itemsList {
        list-style-type: none;
    }
    .right-space {
        margin-right: 4px;
    }
    .bottom-space {
        margin-bottom: 5px;
    }
    .left-float {
        float: left;
    }
    .right-float {
        float: right !important;
    }
    .small-input {
        max-width: 90px;
    }
    .limit-size {
        max-width: 300px;
    }
    .min-width-x {
        min-width: 130px;
    }
    .up-space {
        margin-top: 10px;
    }
    .accordion-toggle {
        display: block;
    }
    .concepto, .conceptoC {
        display: block;
    }
    .concepto:hover {
        background-color: #eaeaea;
        color: #454545;
    }
    .max-width-80 {
        max-width: 80px;
    }
    .toggle-switch span {
        height: auto;
    }
    .toggle-switch {
        border-color: #bbbbbb;
    }
    /*.accordion-toggle:nth-child(2) {*/
        /*height: 32px;*/
    /*}*/
    /*a.accordion-toggle:nth-of-type(2) {*/
        /*height: 32px;*/
    /*}*/
    .panel-group > .panel-default:nth-child(2) a {
        height: 32px;
    }
    .text-muted {
        color: #999;
    }
    .text-muted:hover {
        text-decoration: none;
    }
    </style>

    <script>
        if (!Array.prototype.indexOf)
        {
            Array.prototype.indexOf = function(elt /*, from*/)
            {
                var len = this.length >>> 0;

                var from = Number(arguments[1]) || 0;
                from = (from < 0)
                        ? Math.ceil(from)
                        : Math.floor(from);
                if (from < 0)
                    from += len;

                for (; from < len; from++)
                {
                    if (from in this &&
                            this[from] === elt)
                        return from;
                }
                return -1;
            };
        }

        if (!Array.prototype.every) {
            Array.prototype.every = function(callbackfn, thisArg) {
                'use strict';
                var T, k;

                if (this == null) {
                    throw new TypeError('this is null or not defined');
                }

                // 1. Let O be the result of calling ToObject passing the this
                //    value as the argument.
                var O = Object(this);

                // 2. Let lenValue be the result of calling the Get internal method
                //    of O with the argument "length".
                // 3. Let len be ToUint32(lenValue).
                var len = O.length >>> 0;

                // 4. If IsCallable(callbackfn) is false, throw a TypeError exception.
                if (typeof callbackfn !== 'function') {
                    throw new TypeError();
                }

                // 5. If thisArg was supplied, let T be thisArg; else let T be undefined.
                if (arguments.length > 1) {
                    T = thisArg;
                }

                // 6. Let k be 0.
                k = 0;

                // 7. Repeat, while k < len
                while (k < len) {

                    var kValue;

                    // a. Let Pk be ToString(k).
                    //   This is implicit for LHS operands of the in operator
                    // b. Let kPresent be the result of calling the HasProperty internal
                    //    method of O with argument Pk.
                    //   This step can be combined with c
                    // c. If kPresent is true, then
                    if (k in O) {

                        // i. Let kValue be the result of calling the Get internal method
                        //    of O with argument Pk.
                        kValue = O[k];

                        // ii. Let testResult be the result of calling the Call internal method
                        //     of callbackfn with T as the this value and argument list
                        //     containing kValue, k, and O.
                        var testResult = callbackfn.call(T, kValue, k, O);

                        // iii. If ToBoolean(testResult) is false, return false.
                        if (!testResult) {
                            return false;
                        }
                    }
                    k++;
                }
                return true;
            };
        }

        if (!Array.prototype.some) {
            Array.prototype.some = function(fun/*, thisArg*/) {
                'use strict';

                if (this == null) {
                    throw new TypeError('Array.prototype.some called on null or undefined');
                }

                if (typeof fun !== 'function') {
                    throw new TypeError();
                }

                var t = Object(this);
                var len = t.length >>> 0;

                var thisArg = arguments.length >= 2 ? arguments[1] : void 0;
                for (var i = 0; i < len; i++) {
                    if (i in t && fun.call(thisArg, t[i], i, t)) {
                        return true;
                    }
                }

                return false;
            };
        }

        if (!Array.prototype.forEach) {

            Array.prototype.forEach = function(callback, thisArg) {

                var T, k;

                if (this == null) {
                    throw new TypeError(' this is null or not defined');
                }

                // 1. Let O be the result of calling ToObject passing the |this| value as the argument.
                var O = Object(this);

                // 2. Let lenValue be the result of calling the Get internal method of O with the argument "length".
                // 3. Let len be ToUint32(lenValue).
                var len = O.length >>> 0;

                // 4. If IsCallable(callback) is false, throw a TypeError exception.
                // See: http://es5.github.com/#x9.11
                if (typeof callback !== "function") {
                    throw new TypeError(callback + ' is not a function');
                }

                // 5. If thisArg was supplied, let T be thisArg; else let T be undefined.
                if (arguments.length > 1) {
                    T = thisArg;
                }

                // 6. Let k be 0
                k = 0;

                // 7. Repeat, while k < len
                while (k < len) {

                    var kValue;

                    // a. Let Pk be ToString(k).
                    //   This is implicit for LHS operands of the in operator
                    // b. Let kPresent be the result of calling the HasProperty internal method of O with argument Pk.
                    //   This step can be combined with c
                    // c. If kPresent is true, then
                    if (k in O) {

                        // i. Let kValue be the result of calling the Get internal method of O with argument Pk.
                        kValue = O[k];

                        // ii. Call the Call internal method of callback with T as the this value and
                        // argument list containing kValue, k, and O.
                        callback.call(T, kValue, k, O);
                    }
                    // d. Increase k by 1.
                    k++;
                }
                // 8. return undefined
            };
        }

        if (!Array.prototype.map) {

            Array.prototype.map = function(callback, thisArg) {

                var T, A, k;

                if (this == null) {
                    throw new TypeError(' this is null or not defined');
                }

                // 1. Let O be the result of calling ToObject passing the |this|
                //    value as the argument.
                var O = Object(this);

                // 2. Let lenValue be the result of calling the Get internal
                //    method of O with the argument "length".
                // 3. Let len be ToUint32(lenValue).
                var len = O.length >>> 0;

                // 4. If IsCallable(callback) is false, throw a TypeError exception.
                // See: http://es5.github.com/#x9.11
                if (typeof callback !== 'function') {
                    throw new TypeError(callback + ' is not a function');
                }

                // 5. If thisArg was supplied, let T be thisArg; else let T be undefined.
                if (arguments.length > 1) {
                    T = thisArg;
                }

                // 6. Let A be a new array created as if by the expression new Array(len)
                //    where Array is the standard built-in constructor with that name and
                //    len is the value of len.
                A = new Array(len);

                // 7. Let k be 0
                k = 0;

                // 8. Repeat, while k < len
                while (k < len) {

                    var kValue, mappedValue;

                    // a. Let Pk be ToString(k).
                    //   This is implicit for LHS operands of the in operator
                    // b. Let kPresent be the result of calling the HasProperty internal
                    //    method of O with argument Pk.
                    //   This step can be combined with c
                    // c. If kPresent is true, then
                    if (k in O) {

                        // i. Let kValue be the result of calling the Get internal
                        //    method of O with argument Pk.
                        kValue = O[k];

                        // ii. Let mappedValue be the result of calling the Call internal
                        //     method of callback with T as the this value and argument
                        //     list containing kValue, k, and O.
                        mappedValue = callback.call(T, kValue, k, O);

                        // iii. Call the DefineOwnProperty internal method of A with arguments
                        // Pk, Property Descriptor
                        // { Value: mappedValue,
                        //   Writable: true,
                        //   Enumerable: true,
                        //   Configurable: true },
                        // and false.

                        // In browsers that support Object.defineProperty, use the following:
                        // Object.defineProperty(A, k, {
                        //   value: mappedValue,
                        //   writable: true,
                        //   enumerable: true,
                        //   configurable: true
                        // });

                        // For best browser support, use the following:
                        A[k] = mappedValue;
                    }
                    // d. Increase k by 1.
                    k++;
                }

                // 9. return A
                return A;
            };
        }
    </script>
</head>

<body>
<div class="container-fluid row" ng-app="calculadora" ng-controller="calcularCtrl">
    <div class="col-md-6">
        <div accordion close-others="oneAtATime">
            <div accordion-group ng-repeat="category in categories"
                             is-open="$parent.categoOpened[$index]"
                             is-disabled="category.descripcion === 'Ingeniería en sitio' && !category.selected">
                <div accordion-heading ng-class="category.descripcion === 'Ingeniería en sitio'? 'alto': ''">
                    {{category.descripcion}}
                    <div toggle-switch
                            class="pull-right"
                            on-label="Sí"
                            off-label="No"
                            ng-click="updateOpened(category, categoOpened[$index], $event)"
                            ng-model="category.selected"
                            ng-if="category.descripcion === 'Ingeniería en sitio'"></div>
                </div>


                <ul ng-if="category.descripcion === 'Tipo de cliente' && category.conceptos && category.conceptos.length > 0" class="itemsList">
                    <li ng-repeat="item in category.conceptos">
                        <label class="concepto">
                            <input ng-if="category.multiple" type="checkbox"
                                   name="{{category.id}}-concepto"
                                   checklist-model="category.selected"
                                   checklist-value="item"/>
                            <input ng-if="!category.multiple" type="radio"
                                   name="{{category.id}}-concepto"
                                   ng-model="category.selected"
                                   ng-value="item"/>
                            {{item.descripcion}}
                        </label>
                    </li>
                </ul>


                <div ng-if="category.descripcion === 'Ingeniería en sitio' && category.componentes">
                    %{--<div class="form-inline bottom-space">--}%
                    <div class="form-group col-md-6">
                        <select ng-options="comp as comp.descripcion for comp in category.componentes"
                                ng-model="currentCatego.techSelected"
                                ng-change="showOptions(category)"
                                title="Elige una tecnología"
                                class="form-control input-sm">
                            <option>{{$parent}}</option></select>
                    </div>

                    <div class="form-group col-md-3">
                        <div class=""
                             ng-class="opt.descripcion === 'cantidad'? '': ''"
                             ng-repeat="opt in currentCatego.techSelected.propiedades">
                            <input type="number"
                                   class="form-control input-sm"
                                   placeholder="{{opt.descripcion}}"
                                   ng-class="opt.descripcion === 'cantidad'? 'small-input': ''"
                                   ng-model="opt.valor"
                                   ng-change="registerQuantity(currentCatego.techSelected, opt)"/>
                            <select class="form-control input-sm limit-size" title=""
                                    ng-show="opt.descripcion == 'volumetría'">
                                <option>Small Bussiness hasta 500 usuarios</option>
                                <option>Medium Bussiness hasta 5,000 usuarios</option>
                                <option>Datacenters & Large Enterprise más de 5,000 usuarios</option>
                            </select>
                            <label ng-show="['check', 'boolean'].indexOf(opt.tipo) > -1">
                                <input type="checkbox" ng-model="opt.valor"/>
                                {{opt.descripcion}}
                            </label>
                        </div>
                    </div>
                    %{--</div>--}%

                </div>


                <div ng-if="category.descripcion === 'Tecnología' && category.componentes">
                    %{--<div class="form-inline bottom-space">--}%
                        <div class="form-group col-md-3">
                            <select ng-options="comp as comp.descripcion for comp in category.componentes"
                                    ng-model="currentCatego.techSelected"
                                    ng-change="showOptions(category)"
                                    title="Elige una tecnología"
                                    class="form-control input-sm">
                                <option>{{$parent}}</option></select>
                        </div>

                        <div class="form-group col-md-9">
                            <div class=""
                                 ng-class="opt.descripcion === 'cantidad'? 'col-xs-3': 'col-xs-9'"
                                 ng-repeat="opt in currentCatego.techSelected.propiedades">
                                <input type="number"
                                       class="form-control input-sm"
                                       placeholder="{{opt.descripcion}}"
                                       ng-class="opt.descripcion === 'cantidad'? 'small-input': ''"
                                       ng-show="['int', 'Integer'].indexOf(opt.tipo) > -1"
                                       ng-model="opt.valor"
                                       ng-change="lookForQuantity(currentCatego.techSelected, opt)"/>
                                <select class="form-control input-sm limit-size"
                                        title=""
                                        ng-show="opt.descripcion == 'volumetría'"
                                        ng-model="opt.valor">
                                    <option value="small">Small Bussiness hasta 500 usuarios</option>
                                    <option value="medium">Medium Bussiness hasta 5,000 usuarios</option>
                                    <option value="datacenter">Datacenters & Large Enterprise más de 5,000
                                    usuarios</option>
                                </select>
                                <label ng-show="['check', 'boolean'].indexOf(opt.tipo) > -1">
                                    <input type="checkbox" ng-model="opt.valor"/>
                                    {{opt.descripcion}}
                                </label>
                            </div>
                        </div>
                    %{--</div>--}%

                    %{--<div class="form-group" ng-show="currentCatego.techSelected.auxArray.length > 0">--}%
                        <div class="form-group col-md-12" ng-show="currentCatego.techSelected.auxArray.length > 0">
                            <div class="col-sm-5">
                                <label>
                                    <input type="radio" name="applyTo" value="todos"
                                           ng-model="currentCatego.techSelected.deviceScope"
                                           ng-change="updateTempArr()"/>Todos
                                </label>
                                <label>
                                    <input type="radio" name="applyTo" value="uno"
                                           ng-model="currentCatego.techSelected.deviceScope"
                                           ng-change="updateTempArr()"/>Uno
                                </label>
                                <label>
                                    <input type="radio" name="applyTo" value="varios"
                                           ng-model="currentCatego.techSelected.deviceScope"
                                           ng-change="updateTempArr()"/>Varios
                                </label>
                            </div>
                            <div class="right-float col-xs-12 col-sm-6">
                                <select ng-show="currentCatego.techSelected.deviceScope === 'uno'"
                                        ng-init="currentCatego.techSelected.currentItem = currentCatego.techSelected.auxArray[0]"
                                        ng-options="idx as currentCatego.techSelected.descripcion+' '+idx for idx in currentCatego.techSelected.auxArray"
                                        ng-model="currentCatego.techSelected.currentItem"
                                        ng-change="updateTempArr()"
                                        class="form-control input-sm min-width-x"
                                        title="Elige uno para modificar sus opciones"></select>
                                %{--<select ng-show="currentCatego.techSelected.deviceScope === 'uno'"--}%
                                        %{--ng-init="currentCatego.techSelected.currentItem = currentCatego.techSelected.auxArray[0]"--}%
                                        %{--ng-options="idx as currentCatego.techSelected.descripcion+' '+idx for idx in currentCatego.techSelected.auxArray"--}%
                                        %{--ng-model="currentCatego.techSelected.currentItem"--}%
                                        %{--ng-change="algo(currentCatego.techSelected, currentCatego.techSelected.conceptos,  currentCatego.techSelected.currentItem, currentCatego.techSelected.arr)"--}%
                                        %{--class="form-control input-sm min-width-x"--}%
                                        %{--title="Elige uno para modificar sus opciones"></select>--}%
                                <input type="number"
                                       placeholder="#"
                                       class="form-control input-sm max-width-801"
                                       ng-model="currentCatego.techSelected.range"
                                       ng-change="updateTempArr()"
                                       ng-show="currentCatego.techSelected.deviceScope === 'varios'"/>
                            </div>
                        %{--</div>--}%
                    </div>    %{--{{currentCatego.techSelected.arr}}--}%

                    <div ng-show="isRangeSelected()">
                        <div class="col-md-4"
                             ng-repeat="item in currentCatego.techSelected.conceptos">
                            <label class="conceptoC">
                                <input type="checkbox"
                                       name="{{category.id}}-concepto"
                                       checklist-model="currentCatego.techSelected.tempArr"
                                       checklist-change="updateCatego(currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1])"
                                       checklist-value="item"/>
                                %{--<input type="checkbox"--}%
                                       %{--name="{{category.id}}-concepto"--}%
                                       %{--checklist-model="currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1]"--}%
                                       %{--ng-change="updateCatego(currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1])"--}%
                                       %{--checklist-value="item"/>--}%
                                {{item.descripcion}}
                            </label>
                        </div>    %{--{{currentCatego.techSelected.arr}}--}%
                    <div class="col-md-12 btn-group">
                        <a href="#" class="btn right-float" ng-disabled="currentCatego.techSelected.deviceScope == 'todos'"><span class="glyphicon glyphicon-paste"></span> P</a>
                        <a href="#" class="btn right-float" ng-disabled="currentCatego.techSelected.deviceScope == 'todos'"><span class="glyphicon glyphicon-copy"></span> C</a>
                        <a href="#" class="right-float btn" ng-click="selectNone(currentCatego.techSelected)"><span class="glyphicon glyphicon-unchecked"></span> Ninguno</a>
                        <a href="#" class="right-float btn" ng-click="selectAll(currentCatego.techSelected)"><span class="glyphicon glyphicon-ok"></span> Todos</a>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <div >
                    <h3>Resumen general</h3>
                    %{--<h5>--}%%{--{{categoOpened}} --}%%{--  {{currentCatego.descripcion}}</h5>--}%

                    <div ng-repeat="category in categories">
                        <div ng-if="category.descripcion !== 'Tecnología' && category.descripcion !== 'Ingeniería en sitio' && category.selected && !category.multiple" class="col-md-12 descRow">
                            <div class="col-sm-3">{{category.descripcion}}:</div>

                            <div class="col-sm-9"><strong>{{category.selected.descripcion}}</strong></div>
                        </div>

                        <div ng-if="category.descripcion !== 'Tecnología' && category.descripcion !== 'Ingeniería en sitio' && category.selected && category.selected.length>0 && category.multiple"
                             class="col-md-12 descRow">
                            <div class="col-sm-3">{{category.descripcion}}</div>

                            <div class="col-sm-9">
                                <p ng-repeat="item in category.selected"
                                   class="descMultiRow"><strong>{{item.descripcion}}</strong></p>
                            </div>
                        </div>

                        <div ng-if="category.descripcion === 'Ingeniería en sitio' && category.selected">
                            <div class="col-sm-4">{{category.descripcion}}</div>
                            <div class="col-sm-8">
                                <div ng-repeat="tech in category.componentes">%{--{{tech}}<br/>--}%
                                    <span ng-if="tech.propiedades[0].valor > 0">
                                        {{tech.propiedades[0].valor + ' ' + tech.descripcion}}
                                    </span>
                                    %{--<div ng-show="tech.arr && tech.arr.length > 0">--}%
                                        %{--<h5><em>{{tech.descripcion}}</em> {{tech.nItems}} dispositivos</h5>--}%
                                        %{--<div ng-repeat="item in tech.arr">--}%
                                            %{--<p ng-show="item && item.length > 0"><strong>{{tech.descripcion+' '+(+$index + 1)}}</strong>: {{item | printString:'descripcion'}}</p>--}%
                                        %{--</div>--}%
                                    %{--</div>--}%
                                </div>
                            </div>
                        </div>


                        <div ng-show="category.descripcion === 'Tecnología' && category.selected" class="col-md-12">%{--{{category.techSelected}}--}%
                            <div class="col-sm-3">{{category.descripcion}}:</div>
                            <div class="col-sm-9">
                                <div ng-repeat="tech in category.componentes">
                                    <div ng-show="tech.arr && tech.arr.length > 0">
                                        <h5><em>{{tech.descripcion}}</em> {{tech.nItems}} dispositivos</h5>
                                        <div ng-repeat="item in tech.arr">
                                            <p ng-show="item && item.length > 0"><strong>{{tech.descripcion+' '+(+$index + 1)}}</strong>: {{item | printString:'descripcion'}}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> %{--{{category.selected}}--}%
                    </div>
                </div>

                <button type="button" class="btn btn-primary" ng-click="calcular()" ng-disabled="isReady()">Calcular
                </button>
                <div ng-show="resultados">
                    <h4>Coindice con</h4>
                    <div ng-repeat="res in resultados">
                        <span ng-repeat="ite in res">
                            <p>{{ite.nombre}}: {{ite.descripcion}}</p>
                            <ul ng-if="ite.class.indexOf('Ticket', ite.class.length - 'Ticket'.length) !== -1">
                                <li><span><strong>cc</strong> {{ite.cc}}, <strong>es</strong> {{ite.es}}, <strong>rq
                                </strong> {{ite.rq}}, <strong>as</strong> {{ite.acs}}</span></li>
                                %{--<li><span><strong>cc</strong>{{ite.cc}}</span></li>--}%
                                %{--<li><span><strong>es</strong>{{ite.es}}</span></li>--}%
                                %{--<li><span><strong>rq</strong>{{ite.rq}}</span></li>--}%
                                %{--<li><span><strong>as</strong>{{ite.acs}}</span></li>--}%
                            </ul>
                            <ul ng-if="ite.class.indexOf('Factor', ite.class.length - 'Factor'.length) !== -1">
                                <li><span><strong>factor</strong> {{ite.factor}}, {{ite.lowerLimit}} -
                                {{ite.upperLimit}}</li>
                            </ul>
                        </span>
                    </div>
                </div>
                <div ng-show="noMatches()">
                    Ninguna regla coincide para lo seleccionado
                </div>

            </div>
        </div>
    </div>

</div>

</body>
</html>
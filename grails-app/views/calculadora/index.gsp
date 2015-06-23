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
    <asset:javascript src="ui-bootstrap-tpls-0.10.0.js"/>
    <asset:javascript src="calculadora.js"/>

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
        float: right;
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
        margin-top: 15px;
    }
    .accordion-toggle {
        display: block;
    }
    </style>
</head>

<body>
<div class="row" ng-app="calculadora" ng-controller="calcularCtrl">
    <div class="col-md-6">

        <accordion close-others="oneAtATime">
            <accordion-group ng-repeat="category in categories" is-open="$parent.categoOpened[$index]">
                <accordion-heading>
                    {{category.descripcion}}
                </accordion-heading>


                <ul class="itemsList">
                    <li ng-repeat="item in category.conceptos">
                        <label>
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

                <div ng-if="category.componentes">
                    <div class="form-inline bottom-space">
                        <div class="form-group">
                            <select ng-options="comp as comp.descripcion for comp in category.componentes"
                                    ng-model="currentCatego.techSelected"
                                    ng-change="showOptions(category)"
                                    title="Elige una tecnología"
                                    class="form-control input-sm">
                                <option>{{$parent}}</option></select>
                        </div>

                        <div class="left-float">
                            <div class="form-group right-space"
                                 ng-show="currentCatego.techSelected"
                                 ng-repeat="opt in currentCatego.techSelected.propiedades">
                                <input type="number"
                                       class="form-control input-sm"
                                       placeholder="{{opt.descripcion}}"
                                       ng-class="opt.descripcion === 'cantidad'? 'small-input': ''"
                                       ng-if="['int', 'Integer'].indexOf(opt.tipo) > -1"
                                       ng-model="opt.valor"
                                       ng-change="lookForQuantity(currentCatego.techSelected, opt)"/>
                                <select class="form-control input-sm limit-size" title="" ng-if="opt.descripcion == 'volumetría'">
                                    <option>Small Bussiness hasta 500 usuarios</option>
                                    <option>Medium Bussiness hasta 5,000 usuarios</option>
                                    <option>Datacenters & Large Enterprise más de 5,000 usuarios</option>
                                </select>
                                <label ng-if="['check', 'boolean'].indexOf(opt.tipo) > -1">
                                    <input type="checkbox" ng-model="opt.valor"/>
                                    {{opt.descripcion}}
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-inline bottom-space up-space" ng-show="currentCatego.techSelected.auxArray.length > 0">
                        <div class="form-group">
                            <select ng-init="currentCatego.techSelected.currentItem = currentCatego.techSelected.auxArray[0]"
                                    ng-options="idx as currentCatego.techSelected.descripcion+' '+idx for idx in currentCatego.techSelected.auxArray"
                                    ng-model="currentCatego.techSelected.currentItem"
                                    ng-change="algo(currentCatego.techSelected, currentCatego.techSelected.conceptos,  currentCatego.techSelected.currentItem, currentCatego.techSelected.arr)"
                                    class="form-control input-sm min-width-x"
                                    title="Elige uno para modificar sus opciones"></select>
                        </div>
                    </div>    %{--{{currentCatego.techSelected.arr}}--}%

                    <div ng-show="currentCatego.techSelected.currentItem > 0">
                        <div class="col-md-4"
                             ng-repeat="item in currentCatego.techSelected.conceptos">
                            <label>
                                <input type="checkbox"
                                       name="{{category.id}}-concepto"
                                       checklist-model="currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1]"
                                       ng-change="updateCatego(currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1])"
                                       checklist-value="item"/>
                                {{item.descripcion}}
                            </label>
                        </div>    %{--{{currentCatego.techSelected.arr}}--}%
                    </div>
                </div>
            </accordion-group>
        </accordion>
    </div>


    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <div >
                    <h3>Resumen general</h3>
                    %{--<h5>--}%%{--{{categoOpened}} --}%%{--  {{currentCatego.descripcion}}</h5>--}%

                    <div ng-repeat="category in categories">
                        <div ng-if="category.descripcion !== 'Tecnología' && category.selected && !category.multiple" class="col-md-12 descRow">
                            <div class="col-xs-3">{{category.descripcion}}:</div>

                            <div class="col-xs-9"><strong>{{category.selected.descripcion}}</strong></div>
                        </div>

                        <div ng-if="category.descripcion !== 'Tecnología' && category.selected && category.selected.length>0 && category.multiple"
                             class="col-md-12 descRow">
                            <div class="col-xs-3">{{category.descripcion}}</div>

                            <div class="col-xs-9">
                                <p ng-repeat="item in category.selected"
                                   class="descMultiRow"><strong>{{item.descripcion}}</strong></p>
                            </div>
                        </div>


                        <div ng-show="category.descripcion === 'Tecnología' && isOk(category.techSelected)" class="col-md-12">%{--{{category.techSelected}}--}%
                            <div class="col-xs-3">{{category.descripcion}}:</div>
                            <div class="col-xs-9">
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
            </div>
        </div>
    </div>

</div>

%{--<asset:deferredScripts/>--}%
</body>
</html>
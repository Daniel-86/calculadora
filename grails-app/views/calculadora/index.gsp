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
    %{--<asset:javascript src="calculadora/module.js"/>--}%
    %{--<script>--}%
    %{--angular.module('calculadora' ['ui.bootstrap']);--}%
    %{--</script>--}%
    %{--<asset:javascript src="calculadora/controllers.js"/>--}%
    %{--<asset:javascript src="calculadora/accordion.js"/>--}%
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
                    <div class="form-inline">
                        <div class="form-group">
                            <select ng-options="comp as comp.descripcion for comp in category.componentes"
                                    ng-model="currentCatego.techSelected"
                                    ng-change="showOptions(category)"
                                    title="Elige una tecnología"
                                    class="form-control input-sm">
                                <option>{{$parent}}</option></select>
                        </div>

                        <div class="form-group"
                             ng-show="currentCatego.techSelected"
                             ng-repeat="opt in currentCatego.techSelected.propiedades">
                            <input type="{{opt.tipo}}"
                                   class="form-control input-sm"
                                   placeholder="{{opt.descripcion}}"
                                   ng-model="opt.valor"
                                   ng-change="lookForQuantity(currentCatego.techSelected, opt)"/>
                        </div>
                    </div>

                    <div class="form-inline" ng-show="currentCatego.techSelected.auxArray.length > 0">
                        <div class="form-group">
                            <select ng-model="currentCatego.techSelected.currentItem"
                                    ng-change="algo(currentCatego.techSelected)"
                                    title="Elige uno para modificar sus opciones"
                                    class="form-control input-sm">
                                <option ng-repeat="i in currentCatego.techSelected.auxArray"
                                        ng-model="currentCatego.techSelected.currentItem">
                                    {{currentCatego.techSelected.descripcion + i}}</option>
                            </select>
                        </div>
                    </div>

                    <div ng-show="currentCatego.techSelected">
                        <div class="col-md-6"
                             ng-repeat="item in currentCatego.techSelected.arr[currentCatego.techSelected.currentItem]">
                            {{category.selected.conceptos}}
                            <input type="checkbox" name="{{category.id}}-concepto"
                                   id="{{category.id}}-concepto-{{item.id}}"
                                   ng-change="newUpdateItems(currentCatego.techSelected.arr[$index], item)"
                                   ng-value="item"
                                   ng-model="item.selected"/><label
                                for="{{category.id}}-concepto-{{item.id}}">{{item.descripcion}}</label>
                            {{currentCatego.techSelected.array}}
                        </div>
                    </div>
                </div>
            </accordion-group>
        </accordion>
    </div>


    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <div ng-hide="currentCatego.descripcion === 'Tecnología'">
                    <h3>Resumen general</h3>
                    <h5>{{categoOpened}}   {{currentCatego.descripcion}}</h5>

                    <div ng-repeat="category in categories">
                        <div ng-if="category.selected && !category.multiple" class="col-md-12 descRow">
                            <div class="col-xs-4">{{category.descripcion}}:</div>

                            <div class="col-xs-8"><strong>{{category.selected.descripcion}}</strong></div>
                        </div>

                        <div ng-if="category.selected && category.selected.length>0 && category.multiple"
                             class="col-md-12 descRow">
                            <div class="col-xs-4">{{category.descripcion}}</div>

                            <div class="col-xs-8">
                                <p ng-repeat="item in category.selected"
                                   class="descMultiRow"><strong>{{item.descripcion}}</strong></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div ng-show="currentCatego.descripcion === 'Tecnología'">
                    <h3>Resumen de {{currentCatego.descripcion}}</h3>
                    {{}}
                </div>
            </div>
        </div>

    </div>

</div>

%{--<asset:deferredScripts/>--}%
</body>
</html>
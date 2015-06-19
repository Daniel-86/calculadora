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
                        <input ng-if="category.multiple" type="checkbox"
                               ng-change="updateItems(category, item)"
                               name="{{category.id}}-concepto" id="{{category.id}}-concepto"
                               ng-model="item.selected"
                               ng-value="item"/>
                        %{--<input ng-if="item.multiple" ng-show="category.selected.indexOf(item) > -1" type="number" placeholder="cantidad"/>--}%
                        <input ng-if="!category.multiple" type="radio"
                               ng-model="category.selected"
                               name="{{category.id}}-concepto" id="{{category.id}}-concepto"
                               ng-value="item"/>
                        <label for="{{category.id}}-concepto">{{item.descripcion}}</label>
                    </li>
                </ul>

                <div ng-if="category.componentes">
                    <select ng-options="comp as comp.descripcion for comp in category.componentes"
                            ng-model="category.current" ng-change="showOptions(category)"
                            title="Elige una tecnología"></select>

                    <div ng-show="shwOpts">
                        %{--{{category.current}}--}%
                        <div ng-repeat="opt in category.current.propiedades">
                            <input type="{{opt.tipo}}" placeholder="{{opt.descripcion}}" ng-model="opt.valor"
                                   ng-change="lookForQuantity(category.current, opt)"/>
                        </div>
                        <select ng-model="category.current.currentItem" ng-change="algo(category.current)"
                                title="Elige uno para modificar sus opciones">
                            <option ng-repeat="i in category.current.auxArray"
                                    ng-model="category.current.currentItem">{{techSelected.descripcion + i}}</option>
                        </select>

                        <div class="col-md-6" ng-repeat="item in category.current.arr[category.current.currentItem]">
                            {{category.selected.conceptos}}
                            <input type="checkbox" name="{{category.id}}-concepto"
                                   id="{{category.id}}-concepto-{{item.id}}"
                                   ng-change="newUpdateItems(category.current.arr[$index], item)" ng-value="item"
                                   ng-model="item.selected"/><label
                                for="{{category.id}}-concepto-{{item.id}}">{{item.descripcion}}</label>
                            {{category.current.array}}
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
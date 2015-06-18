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
    <div class="col-md-6" >
        %{--<p>--}%
        %{--<button class="btn btn-default btn-sm" ng-click="status.open = !status.open">Toggle last panel</button>--}%
        %{--<button class="btn btn-default btn-sm" ng-click="status.isFirstDisabled = ! status.isFirstDisabled">Enable / Disable first panel</button>--}%
        %{--</p>--}%

        %{--<label class="checkbox">--}%
        %{--<input type="checkbox" ng-model="oneAtATime">--}%
        %{--Open only one at a time--}%
        %{--</label>--}%

        <accordion close-others="oneAtATime">
            %{--<accordion-group heading="Static Header, initially expanded" is-open="status.isFirstOpen" is-disabled="status.isFirstDisabled">--}%
                %{--This content is straight in the template.--}%
            %{--</accordion-group>--}%
            %{--<accordion-group heading="{{group.title}}" ng-repeat="group in groups">--}%
                %{--{{group.content}}--}%
            %{--</accordion-group>--}%
            %{--<accordion-group heading="Dynamic Body Content">--}%
                %{--<p>The body of the accordion group grows to fit the contents</p>--}%
                %{--<button class="btn btn-default btn-sm" ng-click="addItem()">Add Item</button>--}%
                %{--<div ng-repeat="item in items">{{item}}</div>--}%
            %{--</accordion-group>--}%
            %{--<accordion-group is-open="status.open">--}%
                %{--<accordion-heading>--}%
                    %{--I can have markup, too! <i class="pull-right glyphicon" ng-class="{'glyphicon-chevron-down': status.open, 'glyphicon-chevron-right': !status.open}"></i>--}%
                %{--</accordion-heading>--}%
                %{--This is just some content to illustrate fancy headings.--}%
            %{--</accordion-group>--}%

            <accordion-group ng-repeat="category in categories">
                <accordion-heading>
                    {{category.descripcion}}
                </accordion-heading>


        
                <div ng-if="category.multiple">
                    <ul class="itemsList">
                        <li ng-repeat="item in category.conceptos">
                            <input type="checkbox" ng-change="updateItems(category, item)" name="{{category.id}}-chkbox" ng-model="item.selected" ng-value="item"/>{{item.descripcion}}
                            <input ng-if="item.multiple" ng-show="category.selected.indexOf(item) > -1" type="number" placeholder="cantidad"/>
                        </li>
                        %{--<li ng-repeat="item in category.componentes">--}%
                            %{--<input type="checkbox" ng-change="updateItems(category, item)" name="{{category.id}}-chkbox" ng-model="item.selected" ng-value="item"/>{{item.descripcion}}--}%
                            %{--<div ng-show="category.selected.indexOf(item) > -1">--}%
                                %{--<input ng-repeat="prop in item.propiedades" type="{{prop.tipo}}" placeholder="{{prop.descripcion}}" ng-model="prop.valor"/>--}%
                            %{--</div>--}%
                            %{--<input ng-if="item.multiple" ng-show="category.selected.indexOf(item) > -1" type="number" placeholder="cantidad"/>--}%
                        %{--</li>--}%
                    </ul>

                    <div ng-if="category.componentes">
                        <select ng-options="comp as comp.descripcion for comp in category.componentes" ng-model="category.current" ng-change="showOptions(category)"></select>
                        <div ng-show="shwOpts">
                            %{--{{category.current}}--}%
                            <div ng-repeat="opt in category.current.propiedades">
                                <input type="{{opt.tipo}}" placeholder="{{opt.descripcion}}" ng-model="opt.valor" ng-change="lookForQuantity(category.current, opt)"/>
                            </div>
                            %{--<select ng-options="itemNumber in getQArray()" ng-model="category.basura"></select>--}%
                            <select ng-model="category.current.currentItem" ng-change="algo(category.current)">
                                <option ng-repeat="i in category.current.auxArray" ng-model="category.current.currentItem">{{techSelected.descripcion + i}}</option>
                             </select>
                            <div class="col-md-6" ng-repeat="item in category.current.arr[category.current.currentItem]">
                                %{--{{category.selected.conceptos}}--}%
                                <input type="checkbox" ng-change="newUpdateItems(category.current.arr[$index], item)" ng-value="item" ng-model="item.selected"/>{{item.descripcion}}
                                {{category.current.array}}
                            </div>
                        </div>
                    </div>
                </div>
                <div ng-if="!category.multiple">
                    <ul class="itemsList">
                        <li ng-repeat="item in category.conceptos">
                            <input type="radio" ng-model="category.selected" name="{{category.id}}-rdo" ng-value="item"/>{{item.descripcion}}
                            <input ng-if="item.multiple" type="number" placeholder="cantidad" ng-show="category.selected === item"/>
                        </li>
                        <li ng-repeat="item in category.componentes">
                            <input type="radio" ng-model="category.selected" name="{{category.id}}-rdo" ng-value="item"/>{{item.descripcion}}
                            <input ng-if="item.multiple" type="number" placeholder="cantidad" ng-show="category.selected === item"/>
                        </li>
                    </ul>
                </div>
            </accordion-group>

        </accordion>
    </div>


    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <h3>Resumen general</h3>
                <div ng-repeat="category in categories">
                    <div ng-if="category.selected && !category.multiple" class="col-md-12 descRow">
                        <div class="col-xs-4">{{category.descripcion}}:</div> <div class="col-xs-8"><strong>{{category.selected.descripcion}}</strong></div>
                    </div>
                    <div ng-if="category.selected && category.selected.length>0 && category.multiple" class="col-md-12 descRow">
                        <div class="col-xs-4">{{category.descripcion}}</div>
                        <div class="col-xs-8">
                            <p ng-repeat="item in category.selected" class="descMultiRow"><strong>{{item.descripcion}}</strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    %{--<div class="col-md-6">--}%
        %{--<input ng-repeat="concepto in category.selected.conceptos" type="checkbox"/>{{concepto.descripcion}}--}%
    %{--</div>--}%
</div>

%{--<asset:deferredScripts/>--}%
</body>
</html>
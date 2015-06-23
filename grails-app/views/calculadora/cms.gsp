<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 16/06/2015
  Time: 06:36 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-layout">
    <asset:javascript src="angular/angular.js"/>
    <asset:javascript src="ui-bootstrap-tpls-0.10.0.js"/>
    <asset:javascript src="cms.js"/>
    <title>CMS</title>

    <style>
        .btn-add-prop {
            float: right;
        }
        .new-prop-btns {}
    </style>
</head>

<body>

<div class="container" ng-app="cms" ng-controller="cmsCtrl">
    %{--<div class="row" ng-controller="listasCtrl">--}%
        <div class="col-md-12">
            <ol class="breadcrumb">
                <li>
                    <a href="#" ng-if="tree.length > 0" ng-click="resetView()">Todos</a>
                    <span ng-if="!(tree.length > 0)">Todos</span> </li>
                <li ng-repeat="item in tree" ng-class="{'active':$last}">
                    <a href="#" ng-click="showChildren(item)" ng-if="!$last">{{item.descripcion}}</a>
                    <span ng-if="$last">{{item.descripcion}}</span> </li>
            </ol>
        </div>

        <div ng-class="selected.nodeType == 'LEAF'? 'col-md-12': 'col-md-8'" ng-show="tree.length > 0">
            <div class="panel panel-default">
                <div class="panel-heading"><h4>Datos</h4></div>
                <div class="panel-body">
                    <div ng-if="selected.nodeType == 'ROOT'">
                        <div class="form-group">
                            <label for="descInpt" class="control-label">Descripción</label>
                            <input type="text" class="form-control" id="descInpt" ng-model="selected.descripcion"/>
                        </div>
                    </div>
                    <div ng-if="selected.nodeType == 'LEAF'">
                        <div class="form-group">
                            <label for="descInpt2" class="control-label">Descripción</label>
                            <input type="text" class="form-control" id="descInpt2" ng-model="selected.descripcion"/>
                        </div>
                        <div class="form-group">
                            <label for="costoInpt" class="control-label">Costo</label>
                            <input type="number" class="form-control" id="costoInpt" ng-model="selected.costo"/>
                        </div>
                    </div>
                    <div ng-if="selected.nodeType == 'BRANCH'">
                        <div class="form-group" ng-repeat="prop in selected.propiedades">
                            %{--<label for="propDesc-{{$index}}" class="control-label">Descripción</label>--}%
                            %{--<input type="text" class="form-control" id="propDesc-{{$index}}" ng-model="prop.descripcion"/>--}%
                            %{--<label for="propType-{{$index}}" class="control-label">Tipo</label>--}%
                            %{--<input type="text" class="form-control" id="propType-{{$index}}" ng-model="prop.tipo"/>--}%
                            Propiedad <strong>{{prop.descripcion}}</strong> es de tipo <em>{{prop.tipo}}</em>
                        </div>
                    </div>

                    <div class="col-md-12" ng-if="selected.nodeType == 'BRANCH'">
                        <button class="btn btn-default btn-sm btn-add-prop" ng-click="showPropForm()" ng-hide="newProperty">Nueva propiedad</button>
                    </div>
                    <div ng-if="newProperty">
                        <div class="form-group">
                            <label for="propDesc" class="control-label">Descripción</label>
                            <input type="text" class="form-control" id="propDesc" ng-model="newPropDescripcion"/>
                        </div>
                        <div class="form-group">
                            <label for="propType" class="control-label">Tipo</label>
                            <input type="text" class="form-control" id="propType" ng-model="newPropTipo"/>
                        </div>
                        <div class="btn-group new-prop-btns">
                            <button class="btn btn-default btn-sm btn-add-prop" ng-click="addProp(selected)">Agregar</button>
                            <button class="btn btn-default btn-sm btn-add-prop" ng-click="cancelProp()">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4" ng-if="selected.nodeType != 'LEAF'">
            <div class="list-group">
                <a href="#" class="list-group-item" ng-repeat="child in childrens" ng-click="showChildren(child)">{{child.descripcion}}</a>
            </div>
        </div>

        %{--<div class="col-md-4">--}%
            %{--<div class="list-group">--}%
                %{--<a href="#" class="list-group-item" ng-repeat="category in categories" ng-click="showChildren(category)">{{category.descripcion}}</a>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-4">--}%
            %{--<div class="list-group">--}%
                %{--<a href="#" class="list-group-item" ng-repeat="child in childrens">{{child.descripcion}}</a>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
</div>

</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 30/06/2015
  Time: 01:27 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-backoffice">
    <script>var ticketId = ${factorId?: -1};</script>
    %{--<asset:javascript src="angular/angular.js"/>--}%
    %{--<asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>--}%
    <asset:stylesheet src="ng-sortable.style.css"/>
    <asset:stylesheet src="ng-sortable.css"/>
    <asset:javascript src="angular/modules/ng-sortable.js"/>
    <asset:javascript src="backoffice.js"/>
    <title>backoffice ${section?: ''}</title>

    <style>
        .scrollable-list {
            max-height: 337px;
            overflow: auto;
            min-height: 80px;
            background-color: lightgrey;
            padding: 6px;
        }
        .as-sortable-item, .as-sortable-placeholder {
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
        }
    </style>
</head>

<body>

<div ng-app="backoffice" ng-controller="factorCtrl">
    <div class="col-md-12"  id="dependencies-container">
        <h1>{{factor.id > 0? 'Editar': 'Crear'}}</h1>
        <div ng-show="createForm.generalInfo" class="alert alert-success alert-dismissible" role="alert">
            <button type="button" class='close' data-dismiss="alert"
                    aria-label="Close"><span aria-hidden="true">x</span></button>
            <alert ng-repeat="errorMessage in createForm.generalInfo" type="success"
                   close="">{{errorMessage}}</alert>
        </div>
        <div ng-show="createForm.generalErrors" class="alert alert-danger alert-dismissible" role="alert">
            <button type="button" class='close' data-dismiss="alert"
                    aria-label="Close"><span aria-hidden="true">x</span></button>
            <alert ng-repeat="errorMessage in createForm.generalErrors" type="danger"
                   close="">{{errorMessage}}</alert>
        </div>
        <form novalidate class="" name="createForm" ng-submit="createFactorAjax()">
            %{--<ul>--}%
            %{--<li ng-repeat="item in available">{{item.customId}}</li>--}%

            %{--<div class="col-md-12">--}%
            %{--<label for="nombre" class="control-label">Nombre</label>--}%
            %{--<input id="nombre" class="form-control" ng-model="factor.nombre"/>--}%
        %{--</div>--}%
            <div class="form-horizontal">
                <div class="form-group col-md-3">
                    <label for="nombre" class="control-label col-md-4">Nombre</label>
                    <div class="col-md-8">
                        <input type="text" name="nombre" id="nombre" class="form-control" required
                               ng-model="factor.nombre">
                        <span style="color: #ff0000;" ng-show="createForm.nombre.$dirty && createForm.nombre.$invalid">
                            <span ng-show="createForm.nombre.$error.required">Requerido</span>
                            <span ng-show="createForm.nombre.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.nombre.serverErrors">
                            <span ng-repeat="errorMessage in createForm.nombre.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label for="factor" class="control-label col-md-4">Factor</label>
                    <div class="col-md-8">
                        <input type="number" name="factor" id="factor" class="form-control" step="0.25" required
                               ng-model="factor.factor">
                        <span style="color: #ff0000;" ng-show="createForm.factor.$dirty && createForm.factor.$invalid">
                            <span ng-show="createForm.factor.$error.required">Requerido</span>
                            <span ng-show="createForm.factor.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.factor.serverErrors">
                            <span ng-repeat="errorMessage in createForm.factor.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group col-md-3">
                    <label for="lowerLimit" class="control-label col-md-4">Inferior</label>
                    <div class="col-md-8">
                        <input type="number" name="lowerLimit" id="lowerLimit" class="form-control"
                               ng-model="factor.lowerLimit" min="0">
                        <span style="color: #ff0000;"
                              ng-show="createForm.lowerLimit.$dirty && createForm.lowerLimit.$invalid">
                            <span ng-show="createForm.lowerLimit.$error.required">Requerido</span>
                            <span ng-show="createForm.lowerLimit.$error.min">El valor mínimo es 0</span>
                            <span ng-show="createForm.lowerLimit.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.lowerLimit.serverErrors">
                            <span ng-repeat="errorMessage in createForm.lowerLimit.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group col-md-3">
                    <label for="upperLimit" class="control-label col-md-4">Superior</label>
                    <div class="col-md-8">
                        <input type="number" name="upperLimit" id="upperLimit" class="form-control" min="{{lowerLimit}}"
                               ng-model="factor.upperLimit" depends-on="{{factor.lowerLimit}}"
                               ng-disabled="createForm.lowerLimit.$invalid || !factor.lowerLimit">
                        <span style="color: #ff0000;"
                              ng-show="createForm.upperLimit.$dirty && createForm.upperLimit.$invalid">
                            <span ng-show="createForm.upperLimit.$error.required">Requerido</span>
                            <span ng-show="createForm.upperLimit.$error.min">No puede ser menor a
                            {{factor.lowerLimit}}</span>
                            <span ng-show="createForm.upperLimit.$error.number">Solo números</span>
                            <span ng-show="createForm.upperLimit.$error.range">No puede ser menor a
                            {{factor.lowerLimit}}</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.upperLimit.serverErrors">
                            <span ng-repeat="errorMessage in createForm.upperLimit.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                %{--<div class="form-group">--}%
                    %{--<label for="descripcion" class="control-label col-md-2">Descripción</label>--}%
                    %{--<div class="col-md-10">--}%
                        %{--<textarea id="descripcion" name="descripcion" class="form-control"--}%
                                  %{--ng-model="factor.descripcion"></textarea>--}%
                    %{--</div>--}%
                %{--</div>--}%

            </div>

            <div class="form-group col-md-12">
                <label for="descripcion" class="control-label">Descripción</label>
                <textarea id="descripcion" name="descripcion" class="form-control"
                          ng-model="factor.descripcion"></textarea>
                %{--<div class="">--}%
                    %{--<textarea id="descripcion" name="descripcion" class="form-control"--}%
                              %{--ng-model="factor.descripcion"></textarea>--}%
                %{--</div>--}%
            </div>

            <div class="row">
                <div class="col-md-6" columnindex="0" id="column0">
                    <label for="dependencies">Disponibles</label>
                    <ul as-sortable="dragControlListeners" ng-model="$parent.available" id="dependencies"
                        class="scrollable-list list-group">
                        <li ng-repeat="item in available" as-sortable-item class="list-group-item">
                            <div as-sortable-item-handle>
                                {{item.customId}}
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="col-md-6" columnindex="1" id="column1">
                    <label>Seleccionadas</label>
                    <ul as-sortable="dragControlListeners" ng-model="$parent.selected"
                        class="scrollable-list list-group">
                        <li ng-repeat="item in selected" as-sortable-item class="list-group-item">
                            <div as-sortable-item-handle>
                                {{item.customId}}
                            </div>
                        </li>
                        <li ng-if="!($parent.selected.length>0)">
                            Arrastralos aquí
                        </li>
                    </ul>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" ng-disabled="createForm.$invalid">
                {{factor.id > 0? 'Editar': 'Crear'}}</button>

        </form>
    </div>


</div>

</body>
</html>
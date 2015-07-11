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
    <asset:javascript src="backoffice.js"/>
    <title>backoffice ${section?: ''}</title>

    <style>
    </style>
</head>

<body>

<div ng-app="backoffice" ng-controller="factorCtrl">
    <h1>{{factor.id > 0? 'Editar': 'Crear'}}
            %{--</ul>--}%</h1>
            <div class="col-md-6">
                <form novalidate class="" name="createForm" ng-submit="createFactorAjax()">
                    %{--<ul>--}%
                    %{--<li ng-repeat="item in available">{{item.customId}}</li>--}%

            <div ng-show="createForm.generalInfo" class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class='close' data-dismiss="alert"
                        aria-label="Close"><span aria-hidden="true">x</span></button>
                <alert ng-repeat="errorMessage in createForm.generalInfo" type="success"
                       close="">{{errorMessage}}</alert>
            </div>

            <div class="form-group">
            <label for="dependencies">Dependencias</label>
            <select multiple style="min-height: 150px;" id="dependencies"
                    required
                    class="form-control"
                    ng-model="selected"
                    ng-options="item.customId for item in available"></select>
        </div>
            <div class="form-horizontal">
                <div class="form-group">
                    <label for="factor" class="control-label col-md-2">Factor</label>
                    <div class="col-md-10">
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

                <div class="form-group">
                    <label for="lowerLimit" class="control-label col-md-2">Inferior</label>
                    <div class="col-md-10">
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

                <div class="form-group">
                    <label for="upperLimit" class="control-label col-md-2">Superior</label>
                    <div class="col-md-10">
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
                            {{lowerLimit}}</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.upperLimit.serverErrors">
                            <span ng-repeat="errorMessage in createForm.upperLimit.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="descripcion" class="control-label col-md-2">Descripción</label>
                    <div class="col-md-10">
                        <textarea id="descripcion" name="descripcion" class="form-control"
                                  ng-model="factor.descripcion"></textarea>
                    </div>
                </div>

                %{--<div class="form-group">--}%
                    %{--<label for="rq" class="control-label col-md-2">RQ</label>--}%
                    %{--<div class="col-md-10">--}%
                        %{--<input type="number" name="rq" id="rq" class="form-control" required ng-model="rq">--}%
                        %{--<span style="color: #ff0000;" ng-show="createForm.rq.$dirty">--}%
                            %{--<span ng-show="createForm.rq.$error.required">Requerido</span>--}%
                        %{--</span>--}%
                    %{--</div>--}%
                %{--</div>--}%
            </div>

            <button type="submit" class="btn btn-primary" ng-disabled="createForm.$invalid">{{factor.id
            > 0? 'Editar': 'Crear'}}</button>

        </form>
    </div>

    <div class="col-md-6">
        %{--{{selected}}--}%
        <ul>
            <li ng-repeat="sel in selected">{{sel.customId}}</li>
        </ul>
        %{--{{createForm.factor.$invalid}}--}%
        %{--{{createForm.lowerLimit.$invalid}}--}%
        %{--{{createForm.upperLimit.$invalid}}--}%
    </div>
</div>

</body>
</html>
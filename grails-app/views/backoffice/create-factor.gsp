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
    %{--<asset:javascript src="angular/angular.js"/>--}%
    %{--<asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>--}%
    <asset:javascript src="backoffice.js"/>
    <title>backoffice ${section?: ''}</title>

    <style>
    </style>
</head>

<body>

<div ng-app="backoffice" ng-controller="factorCtrl">
    <div class="col-md-6">
        <form novalidate class="" name="createForm" ng-submit="createFactorAjax()">
            %{--<ul>--}%
            %{--<li ng-repeat="item in available">{{item.customId}}</li>--}%
            %{--</ul>--}%

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
                               ng-model="factor">
                        <span style="color: #ff0000;" ng-show="createForm.cc.$dirty">
                            <span ng-show="createForm.cc.$error.required">Requerido</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="lowerLimit" class="control-label col-md-2">Inferior</label>
                    <div class="col-md-10">
                        <input type="number" name="lowerLimit" id="lowerLimit" class="form-control" ng-model="lowerLimit">
                        <span style="color: #ff0000;" ng-show="createForm.lowerLimit.$dirty">
                            <span ng-show="createForm.lowerLimit.$error.required">Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.lowerLimit.serverErrors">
                            <span ng-repeat="errorMessage in createForm.lowerLimit.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="upperLimit" class="control-label col-md-2">Superior</label>
                    <div class="col-md-10">
                        <input type="number" name="upperLimit" id="upperLimit" class="form-control"
                               ng-model="upperLimit">
                        <span style="color: #ff0000;" ng-show="createForm.upperLimit.$dirty">
                            <span ng-show="createForm.upperLimit.$error.required">Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.upperLimit.serverErrors">
                            <span ng-repeat="errorMessage in createForm.upperLimit.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="descripcion" class="control-label col-md-2">Descripción</label>
                    <div class="col-md-10">
                        <textarea id="descripcion" name="descripcion" class="form-control"></textarea>
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

            <button type="submit" class="btn btn-primary" ng-disabled="isDirty()">Crear</button>

        </form>
    </div>

    <div class="col-md-6">
        {{selected}}
        {{isDirty()}}
    </div>
</div>

</body>
</html>
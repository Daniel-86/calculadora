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
    .btn-add-prop {
        float: right;
    }
    .new-prop-btns {}
    </style>
</head>

<body>

<div ng-app="backoffice" ng-controller="ticketCtrl">
    <div class="col-md-6">
        <form novalidate class="" name="createTForm" ng-submit="createTicketAjax()">
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
                    <label for="cc" class="control-label col-md-1">CC</label>
                    <div class="col-md-10">
                        <input type="number" name="cc" id="cc" class="form-control" required ng-model="cc">
                        <span style="color: #ff0000;" ng-show="createTForm.cc.$dirty">
                            <span ng-show="createTForm.cc.$error.required">Requerido</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="es" class="control-label col-md-1">ES</label>
                    <div class="col-md-10">
                        <input type="number" name="es" id="es" class="form-control" required ng-model="es">
                        <span style="color: #ff0000;" ng-show="createTForm.es.$dirty">
                            <span ng-show="createTForm.es.$error.required">Requerido</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="acs" class="control-label col-md-1">AS</label>
                    <div class="col-md-10">
                        <input type="number" name="acs" id="acs" class="form-control" required ng-model="acs">
                        <span style="color: #ff0000;" ng-show="createTForm.acs.$dirty">
                            <span ng-show="createTForm.acs.$error.required">Requerido</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="rq" class="control-label col-md-1">RQ</label>
                    <div class="col-md-10">
                        <input type="number" name="rq" id="rq" class="form-control" required ng-model="rq">
                        <span style="color: #ff0000;" ng-show="createTForm.rq.$dirty">
                            <span ng-show="createTForm.rq.$error.required">Requerido</span>
                        </span>
                    </div>
                </div>
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
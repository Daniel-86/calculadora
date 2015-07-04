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
    <script>
        var ticketId = ${ticketId};
    </script>
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

<div ng-app="backoffice" ng-controller="editTicketCtrl">
    <div class="col-md-6">
        <form novalidate class="" name="createTForm" ng-submit="createTicketAjax()">
            %{--<ul>--}%
            %{--<li ng-repeat="item in available">{{item.customId}}</li>--}%
            %{--</ul>--}%
            <span style="color: #ff0000;" ng-show="createTForm.generalErrors">
                <span ng-repeat="errorMessage in createTForm.generalErrors">{{errorMessage}}</span>
            </span>

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
                        <input type="number" min="0" name="cc" id="cc" class="form-control" required
                               ng-model="ticket.cc">
                        <span style="color: #ff0000;" ng-show="createTForm.cc.$dirty">
                            <span ng-show="createTForm.cc.$error.required">Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.cc.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.cc.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="es" class="control-label col-md-1">ES</label>
                    <div class="col-md-10">
                        <input type="number" min="0" name="es" id="es" class="form-control" required
                               ng-model="ticket.es">
                        <span style="color: #ff0000;" ng-show="createTForm.es.$dirty">
                            <span ng-show="createTForm.es.$error.required">Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.es.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.es.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="acs" class="control-label col-md-1">AS</label>
                    <div class="col-md-10">
                        <input type="number" min="0" name="acs" id="acs" class="form-control" required
                               ng-model="ticket.acs">
                        <span style="color: #ff0000;" ng-show="createTForm.acs.$dirty">
                            <span ng-show="createTForm.acs.$error.required">Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.acs.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.acs.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="rq" class="control-label col-md-1">RQ</label>
                    <div class="col-md-10">
                        <input type="number" min="0" name="rq" id="rq" class="form-control" required
                               ng-model="ticket.rq">
                        <span style="color: #ff0000;" ng-show="createTForm.rq.$dirty">
                            <span ng-show="createTForm.rq.$error.required">Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.rq.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.rq.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" ng-disabled="isDirty()">Crear</button>

        </form>
    </div>

    <div class="col-md-6">
        %{--{{selected}}--}%
        %{--{{isDirty()}}--}%
        <ul>
        <li ng-repeat="sel in selected">{{sel.customId}}</li>
    </ul>
    </div>
</div>

</body>
</html>
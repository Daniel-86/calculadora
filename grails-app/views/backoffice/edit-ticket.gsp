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
        var ticketId = ${ticketId?: -1};
    </script>
    <title>backoffice ${section ?: ''}</title>

    %{--<asset:javascript src="angular/angular-1.3.js"/>--}%
    %{--<asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>--}%
    %{--<asset:javascript src="backoffice.js"/>--}%

    <style>
    .btn-add-prop {
        float: right;
    }

    .new-prop-btns {
    }
    </style>
</head>

<body>

<div ng-app="backoffice" ng-controller="ticketCtrl">
    <div class="col-md-12" id="dependencies-container">
        <h1>{{ticket.id > 0? 'Editar': 'Crear'}}</h1>

        <div ng-show="createTForm.generalInfo" class="alert alert-success alert-dismissible" role="alert">
            <button type="button" class='close' data-dismiss="alert"
                    aria-label="Close"><span aria-hidden="true">x</span></button>
            <alert ng-repeat="errorMessage in createTForm.generalInfo" type="success"
                   close="">{{errorMessage}}</alert>
        </div>

        <div ng-show="createTForm.generalErrors" class="alert alert-danger alert-dismissible" role="alert">
            <button type="button" class='close' data-dismiss="alert"
                    aria-label="Close"><span aria-hidden="true">x</span></button>
            <alert ng-repeat="errorMessage in createTForm.generalErrors" type="danger"
                   close="">{{errorMessage}}</alert>
        </div>

        %{--<div alert ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</div>--}%

        <form novalidate class="" name="createTForm" ng-submit="createTicketAjax()">
            <div class="form-horizontal">
                <div class="form-group">
                    <label for="nombre" class="control-label col-sm-1">Nombre</label>
                    <div class="col-sm-5">
                        <input id="nombre" ng-model="ticket.nombre" class="form-control" required name="nombre"/>
                        <span style="color: #ff0000;" ng-show="createTForm.nombre.$dirty && createTForm.nombre.$invalid">
                            <span ng-show="createTForm.nombre.$error.required">
                                Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.nombre.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.nombre.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <label for="cc" class="control-label col-sm-4">CC</label>
                    <div class="col-sm-8">
                        <input type="number" min="0" name="cc" id="cc" class="form-control" required
                               ng-model="ticket.cc">
                        <span style="color: #ff0000;" ng-show="createTForm.cc.$dirty && createTForm.cc.$invalid">
                            <span ng-show="!createTForm.cc.$error.number && createTForm.cc.$error.required">Requerido
                            </span>
                            <span ng-show="createTForm.cc.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.cc.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.cc.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group col-md-3">
                    <label for="es" class="control-label col-sm-4">ES</label>

                    <div class="col-sm-8">
                        <input type="number" min="0" name="es" id="es" class="form-control" required
                               ng-model="ticket.es">
                        <span style="color: #ff0000;" ng-show="createTForm.es.$dirty && createTForm.es.$dirty">
                            <span ng-show="!createTForm.es.$error.number && createTForm.es.$error.required">Requerido
                            </span>
                            <span ng-show="createTForm.es.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.es.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.es.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group col-md-3">
                    <label for="acs" class="control-label col-sm-4">AS</label>

                    <div class="col-sm-8">
                        <input type="number" min="0" name="acs" id="acs" class="form-control" required
                               ng-model="ticket.acs">
                        <span style="color: #ff0000;" ng-show="createTForm.acs.$dirty && createTForm.acs.$dirty">
                            <span ng-show="!createTForm.acs.$error.number && createTForm.acs.$error.required">Requerido
                            </span>
                            <span ng-show="createTForm.acs.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.acs.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.acs.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group col-md-3">
                    <label for="rq" class="control-label col-sm-4">RQ</label>

                    <div class="col-sm-8">
                        <input type="number" min="0" name="rq" id="rq" class="form-control" required
                               ng-model="ticket.rq">
                        <span style="color: #ff0000;" ng-show="createTForm.rq.$dirty && createTForm.rq.$dirty">
                            <span ng-show="!createTForm.rq.$error.number && createTForm.rq.$error.required">Requerido
                            </span>
                            <span ng-show="createTForm.rq.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createTForm.rq.serverErrors">
                            <span ng-repeat="errorMessage in createTForm.rq.serverErrors">
                                {{errorMessage}}</span>
                        </span>
                    </div>
                </div>
            </div>

            <div class="form-group col-md-12">
                <label for="descripcion" class="control-label">Descripción</label>
                <textarea id="descripcion" name="descripcion" class="form-control"
                          ng-model="ticket.descripcion"></textarea>
            </div>

            <div class="row">
                <div class="col-md-6" columnIndex="0" id="column0">
                    <label for="dependencies">Disponibles</label>
                    <ul as-sortable="dragControlListeners" ng-model="$parent.available" id="dependencies"
                        class="scrollable-list list-group">
                        <li ng-repeat="item in available" as-sortable-item class="list-group-item">
                            <div as-sortable-item-handle>{{item.customId}}</div>
                        </li>
                    </ul>
                </div>
                <div class="col-md-6" columnIndex="1" id="column1">
                    <label for="selected">Seleccionadas</label>
                    <ul as-sortable="dragControlListeners" ng-model="$parent.selected" id="selected"
                        class="scrollable-list list-group">
                        <li ng-repeat="item in selected" as-sortable-item class="list-group-item">
                            <div as-sortable-item-handle>{{item.customId}}</div>
                        </li>
                        <li ng-if="!($parent.selected.length>0)">
                            Arrastralos aquí
                        </li>
                    </ul>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" ng-disabled="createTForm.$invalid">{{ticket.id > 0? 'Editar':
            'Crear'}}</button>
        </form>
    </div>
</div>

</body>
</html>
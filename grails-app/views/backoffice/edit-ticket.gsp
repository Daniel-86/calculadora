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

</head>

<body>

<div ng-app="backoffice" ng-controller="ticketCtrl">
    <div class="col-md-12" id="dependencies-container">
        <h1>{{ticket.id > 0? 'Editar': 'Crear'}}</h1>

        <div alert ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</div>

        <form novalidate class="" name="createTForm" ng-submit="createTicketAjax()">
            <div class="form-horizontal col-md-12">
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

            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading"><h5>Dependencias</h5></div>
                    <div class="panel-body">Usa el select para agregar más dependencias</div>
                    <table class="table table-striped">
                        <thead>
                        <th>ID</th>
                        <th>Inferior</th>
                        <th>Superior</th>
                        <th>step</th>
                        <th></th>
                        </thead>
                        <tbody>
                        <tr  ng-form="tempForm" ng-repeat="dependency in ticket.dependencies"
                             title="{{dependency.item.descripcion}}">
                            <td>{{dependency.item.customId}}</td>
                            <td>
                                <input class="form-control number" type="number"
                                       ng-model="dependency.lowerLimit" min="0"
                                       name="lowerLimit">
                                <span style="color: #ff0000;"
                                      ng-show="tempForm.lowerLimit.$dirty && tempForm.lowerLimit.$invalid">
                                    <span
                                            ng-show="!tempForm.lowerLimit.$error.number && tempForm.lowerLimit.$error.required">Requerido</span>
                                    <span ng-show="tempForm.lowerLimit.$error.min">El
                                    valor mínimo es 0</span>
                                    <span ng-show="tempForm.lowerLimit.$error.number">Solo números</span>
                                </span>
                                <span style="color: #ff0000;" ng-show="createTForm[dependency.item.customId+'.lowerLimit'].serverErrors">
                                    <span ng-repeat="errorMessage in createTForm[dependency.item.customId+'.lowerLimit'].serverErrors">{{errorMessage}}</span>
                                </span>
                            </td>
                            <td>
                                <input type="number"
                                       name="upperLimit"
                                       class="form-control number"
                                       min="{{dependency.lowerLimit}}"
                                       ng-model="dependency.upperLimit"
                                       depends-on="{{dependency.lowerLimit}}"
                                       ng-disabled="tempForm.lowerLimit.$invalid || !dependency.lowerLimit">
                                <span style="color: #ff0000;"
                                      ng-show="tempForm.upperLimit.$dirty && tempForm.upperLimit.$invalid">
                                    <span
                                            ng-show="!tempForm.upperLimit.$error.number && tempForm.upperLimit.$error.required">
                                        Requerido</span>
                                    <span ng-show="tempForm.upperLimit.$error.min">No puede ser menor a
                                    {{dependency.lowerLimit}}</span>
                                    <span ng-show="tempForm.upperLimit.$error.number">Solo números</span>
                                    <span
                                            ng-show="!tempForm.upperLimit.$error.number && tempForm.upperLimit.$error.range">No puede ser
                                    menor a
                                    {{dependency.lowerLimit}}</span>
                                </span>
                                <span style="color: #ff0000;" ng-show="tempForm.upperLimit.serverErrors">
                                    <span ng-repeat="errorMessage in tempForm.upperLimit.serverErrors">{{errorMessage}}</span>
                                </span>
                            </td>
                            <td>
                                <input class="form-control number" type="number"
                                       ng-model="dependency.step" name="step">
                                <span style="color: #ff0000;"
                                      ng-show="tempForm.step.$dirty && tempForm.step.$invalid">
                                    <span
                                            ng-show="!tempForm.step.$error.number && tempForm.step.$error.required">Requerido</span>
                                    <span ng-show="tempForm.step.$error.min">El
                                    valor mínimo es 0</span>
                                    <span ng-show="tempForm.step.$error.number">Solo números</span>
                                </span>
                                <span style="color: #ff0000;" ng-show="createTForm[dependency.item.customId+'.step'].serverErrors">
                                    <span ng-repeat="errorMessage in createTForm[dependency.item.customId+'.step'].serverErrors">{{errorMessage}}</span>
                                </span>
                            </td>
                            <td><a href="" ng-click="dropDep($index)"
                                   class="btn btn-danger"
                                   title="eliminar"><i
                                        class="glyphicon glyphicon-trash"></i>
                            </a> </td>
                        </tr>
                        <tr title="Agregar dependencia">
                            <td>
                                <select ng-model="lastAdded"
                                        ng-options="ava as ava.customId for ava in available"
                                        ng-change="addDepRow()"
                                        title="Selecciona para agregar"
                                        class="form-control">
                                    <option>Elige alguna</option>
                                </select>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>

            <button type="submit" class="btn btn-primary" ng-disabled="createTForm.$invalid">{{ticket.id > 0? 'Editar':
            'Crear'}}</button>
        </form>
    </div>
</div>

</body>
</html>
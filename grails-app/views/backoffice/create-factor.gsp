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

    <title>backoffice ${section ?: ''}</title>

    <style>

    </style>
</head>

<body>

<div ng-app="backoffice" ng-controller="factorCtrl">
    <div class="col-md-12" id="dependencies-container">
        <h1>{{factor.id > 0? 'Editar': 'Crear'}}</h1>

        <div alert ng-repeat="alert in alerts" type="{{alert.type}}" close="closeAlert($index)">{{alert.msg}}</div>

        <form novalidate class="" name="createForm" ng-submit="createFactorAjax()">
            <div class="form-horizontal col-md-12">
                <div class="form-group col-md-5">
                    <label for="nombre" class="control-label col-md-4">Nombre</label>

                    <div class="col-md-8">
                        <input type="text" name="nombre" id="nombre" class="form-control" required
                               ng-model="factor.nombre">
                        <span style="color: #ff0000;" ng-show="createForm.nombre.$dirty && createForm.nombre.$invalid">
                            <span ng-show="createForm.nombre.$error.required">
                                Requerido</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.nombre.serverErrors">
                            <span ng-repeat="errorMessage in createForm.nombre.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

                <div class="form-group col-md-5">
                    <label for="factor" class="control-label col-md-4">Factor</label>

                    <div class="col-md-8">
                        <input type="number" name="factor" id="factor" class="form-control" step="0.25" required
                               ng-model="factor.factor">
                        <span style="color: #ff0000;" ng-show="createForm.factor.$dirty && createForm.factor.$invalid">
                            <span ng-show="!createForm.factor.$error.number && createForm.factor.$error.required">
                                Requerido</span>
                            <span ng-show="createForm.factor.$error.number">Solo números</span>
                        </span>
                        <span style="color: #ff0000;" ng-show="createForm.factor.serverErrors">
                            <span ng-repeat="errorMessage in createForm.factor.serverErrors">{{errorMessage}}</span>
                        </span>
                    </div>
                </div>

            </div>

            <div class="form-group col-md-12">
                <label for="descripcion" class="control-label">Descripción</label>
                <textarea id="descripcion" name="descripcion" class="form-control"
                          ng-model="factor.descripcion"></textarea>
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
                        <tr  ng-form="tempForm" ng-repeat="dependency in factor.dependencies"
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
                                <span style="color: #ff0000;" ng-show="createForm[dependency.item.customId+'.lowerLimit'].serverErrors">
                                    <span ng-repeat="errorMessage in createForm[dependency.item.customId+'.lowerLimit'].serverErrors">{{errorMessage}}</span>
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
                                <span style="color: #ff0000;" ng-show="createForm[dependency.item.customId+'.step'].serverErrors">
                                    <span ng-repeat="errorMessage in createForm[dependency.item.customId+'.step'].serverErrors">{{errorMessage}}</span>
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

            <button type="submit" class="btn btn-primary" ng-disabled="createForm.$invalid">
                {{factor.id > 0? 'Editar': 'Crear'}}</button>

        </form>
    </div>

</div>

</body>
</html>
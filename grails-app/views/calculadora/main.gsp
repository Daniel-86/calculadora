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
    <asset:javascript src="angular/modules/checklist-model.js"/>
    <asset:javascript src="angular/modules/angular-toggle-switch.min.js"/>
    <asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>
    <asset:javascript src="calculadora.js"/>

    <asset:stylesheet src="angular-toggle-switch.css"/>

    <style>
    </style>

    <script>
    </script>
</head>

<body>
<div class="container-fluid row" ng-app="calculadora" ng-controller="CalculadoraMainCtrl">
    <div class="col-md-6">
        <div accordion close-others="oneAtATime">
            <div accordion-group ng-repeat="category in categories"
                 is-open="true"
                 is-disabled="true">
                <div accordion-heading ng-class="category.customId === 'ingenieria_en_sitio'? 'alto': ''">
                    {{category.descripcion}}
                    <div toggle-switch
                         class="pull-right"
                         on-label="Sí"
                         off-label="No"
                         ng-click="toggleSelected(category, isSelected)"
                         ng-model="isSelected"
                         ng-if="category.customId === 'ingenieria_en_sitio'"></div>
                </div>


                <ul ng-if="category.customId === 'tipo_de_cliente'" class="itemsList">
                    <li ng-repeat="item in category.conceptos">
                        <label class="concepto">
                            <input ng-if="category.multiple"
                                   type="checkbox"
                                   name="{{category.id}}-concepto"
                                   checklist-model="category.selected"
                                   checklist-value="item"/>
                            <input ng-if="!category.multiple"
                                   type="radio"
                                   name="{{category.id}}-concepto"
                                   ng-model="category.selected"
                                   ng-value="item"/>
                            {{item.descripcion}}
                        </label>
                    </li>
                </ul>


                %{--<div ng-if="category.descripcion === 'Ingeniería en sitio' && category.componentes">--}%
                    %{--<div class="form-group col-md-6">--}%
                        %{--<select ng-options="comp as comp.descripcion for comp in category.componentes"--}%
                                %{--ng-model="currentCatego.techSelected"--}%
                                %{--ng-change="showOptions(category)"--}%
                                %{--title="Elige una tecnología"--}%
                                %{--class="form-control input-sm">--}%
                            %{--<option>{{$parent}}</option></select>--}%
                    %{--</div>--}%

                    %{--<div class="form-group col-md-3">--}%
                        %{--<div class=""--}%
                             %{--ng-class="opt.descripcion === 'cantidad'? '': ''"--}%
                             %{--ng-repeat="opt in currentCatego.techSelected.propiedades">--}%
                            %{--<input type="number"--}%
                                   %{--class="form-control input-sm"--}%
                                   %{--placeholder="{{opt.descripcion}}"--}%
                                   %{--ng-class="opt.descripcion === 'cantidad'? 'small-input': ''"--}%
                                   %{--ng-model="opt.valor"--}%
                                   %{--ng-change="registerQuantity(currentCatego.techSelected, opt)"/>--}%
                            %{--<select class="form-control input-sm limit-size" title=""--}%
                                    %{--ng-show="opt.descripcion == 'volumetría'">--}%
                                %{--<option>Small Bussiness hasta 500 usuarios</option>--}%
                                %{--<option>Medium Bussiness hasta 5,000 usuarios</option>--}%
                                %{--<option>Datacenters & Large Enterprise más de 5,000 usuarios</option>--}%
                            %{--</select>--}%
                            %{--<label ng-show="['check', 'boolean'].indexOf(opt.tipo) > -1">--}%
                                %{--<input type="checkbox" ng-model="opt.valor"/>--}%
                                %{--{{opt.descripcion}}--}%
                            %{--</label>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%


                %{--<div ng-if="category.descripcion === 'Tecnología' && category.componentes">--}%
                        %{--<div class="form-group col-md-3">--}%
                            %{--<select ng-options="comp as comp.descripcion for comp in category.componentes"--}%
                                    %{--ng-model="currentCatego.techSelected"--}%
                                    %{--ng-change="showOptions(category)"--}%
                                    %{--title="Elige una tecnología"--}%
                                    %{--class="form-control input-sm">--}%
                                %{--<option>{{$parent}}</option></select>--}%
                        %{--</div>--}%

                        %{--<div class="form-group col-md-9">--}%
                            %{--<div class=""--}%
                                 %{--ng-class="opt.descripcion === 'cantidad'? 'col-xs-3': 'col-xs-9'"--}%
                                 %{--ng-repeat="opt in currentCatego.techSelected.propiedades">--}%
                                %{--<input type="number"--}%
                                       %{--class="form-control input-sm"--}%
                                       %{--placeholder="{{opt.descripcion}}"--}%
                                       %{--ng-class="opt.descripcion === 'cantidad'? 'small-input': ''"--}%
                                       %{--ng-show="['int', 'Integer'].indexOf(opt.tipo) > -1"--}%
                                       %{--ng-model="opt.valor"--}%
                                       %{--ng-change="lookForQuantity(currentCatego.techSelected, opt)"/>--}%
                                %{--<select class="form-control input-sm limit-size"--}%
                                        %{--title=""--}%
                                        %{--ng-show="opt.descripcion == 'volumetría'"--}%
                                        %{--ng-model="opt.valor">--}%
                                    %{--<option value="small">Small Bussiness hasta 500 usuarios</option>--}%
                                    %{--<option value="medium">Medium Bussiness hasta 5,000 usuarios</option>--}%
                                    %{--<option value="datacenter">Datacenters & Large Enterprise más de 5,000--}%
                                    %{--usuarios</option>--}%
                                %{--</select>--}%
                                %{--<label ng-show="['check', 'boolean'].indexOf(opt.tipo) > -1">--}%
                                    %{--<input type="checkbox" ng-model="opt.valor"/>--}%
                                    %{--{{opt.descripcion}}--}%
                                %{--</label>--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        %{--<div class="form-group col-md-12" ng-show="currentCatego.techSelected.auxArray.length > 0">--}%
                            %{--<div class="col-sm-5">--}%
                                %{--<label>--}%
                                    %{--<input type="radio" name="applyTo" value="todos"--}%
                                           %{--ng-model="currentCatego.techSelected.deviceScope"--}%
                                           %{--ng-change="updateTempArr()"/>Todos--}%
                                %{--</label>--}%
                                %{--<label>--}%
                                    %{--<input type="radio" name="applyTo" value="uno"--}%
                                           %{--ng-model="currentCatego.techSelected.deviceScope"--}%
                                           %{--ng-change="updateTempArr()"/>Uno--}%
                                %{--</label>--}%
                                %{--<label>--}%
                                    %{--<input type="radio" name="applyTo" value="varios"--}%
                                           %{--ng-model="currentCatego.techSelected.deviceScope"--}%
                                           %{--ng-change="updateTempArr()"/>Varios--}%
                                %{--</label>--}%
                            %{--</div>--}%
                            %{--<div class="right-float col-xs-12 col-sm-6">--}%
                                %{--<select ng-show="currentCatego.techSelected.deviceScope === 'uno'"--}%
                                        %{--ng-init="currentCatego.techSelected.currentItem = currentCatego.techSelected.auxArray[0]"--}%
                                        %{--ng-options="idx as currentCatego.techSelected.descripcion+' '+idx for idx in currentCatego.techSelected.auxArray"--}%
                                        %{--ng-model="currentCatego.techSelected.currentItem"--}%
                                        %{--ng-change="updateTempArr()"--}%
                                        %{--class="form-control input-sm min-width-x"--}%
                                        %{--title="Elige uno para modificar sus opciones"></select>--}%
                                %{--<input type="number"--}%
                                       %{--placeholder="#"--}%
                                       %{--class="form-control input-sm max-width-801"--}%
                                       %{--ng-model="currentCatego.techSelected.range"--}%
                                       %{--ng-change="updateTempArr()"--}%
                                       %{--ng-show="currentCatego.techSelected.deviceScope === 'varios'"/>--}%
                            %{--</div>--}%
                    %{--</div>--}%

                    %{--<div ng-show="isRangeSelected()">--}%
                        %{--<div class="col-md-4"--}%
                             %{--ng-repeat="item in currentCatego.techSelected.conceptos">--}%
                            %{--<label class="conceptoC">--}%
                                %{--<input type="checkbox"--}%
                                       %{--name="{{category.id}}-concepto"--}%
                                       %{--checklist-model="currentCatego.techSelected.tempArr"--}%
                                       %{--checklist-change="updateCatego(currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1])"--}%
                                       %{--checklist-value="item"/>--}%
                                %{--{{item.descripcion}}--}%
                            %{--</label>--}%
                        %{--</div>--}%
                    %{--<div class="col-md-12 btn-group">--}%
                        %{--<a href="#" class="btn right-float" ng-disabled="currentCatego.techSelected.deviceScope == 'todos'"><span class="glyphicon glyphicon-paste"></span> P</a>--}%
                        %{--<a href="#" class="btn right-float" ng-disabled="currentCatego.techSelected.deviceScope == 'todos'"><span class="glyphicon glyphicon-copy"></span> C</a>--}%
                        %{--<a href="#" class="right-float btn" ng-click="selectNone(currentCatego.techSelected)"><span class="glyphicon glyphicon-unchecked"></span> Ninguno</a>--}%
                        %{--<a href="#" class="right-float btn" ng-click="selectAll(currentCatego.techSelected)"><span class="glyphicon glyphicon-ok"></span> Todos</a>--}%
                    %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
            </div>
        </div>
    </div>


    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <div >
                    <h3>Resumen general</h3>
                    %{--<div ng-repeat="category in categories">--}%
                        %{--<div ng-if="category.descripcion !== 'Tecnología' && category.descripcion !== 'Ingeniería en sitio' && category.selected && !category.multiple" class="col-md-12 descRow">--}%
                            %{--<div class="col-sm-3">{{category.descripcion}}:</div>--}%

                            %{--<div class="col-sm-9"><strong>{{category.selected.descripcion}}</strong></div>--}%
                        %{--</div>--}%

                        %{--<div ng-if="category.descripcion !== 'Tecnología' && category.descripcion !== 'Ingeniería en sitio' && category.selected && category.selected.length>0 && category.multiple"--}%
                             %{--class="col-md-12 descRow">--}%
                            %{--<div class="col-sm-3">{{category.descripcion}}</div>--}%

                            %{--<div class="col-sm-9">--}%
                                %{--<p ng-repeat="item in category.selected"--}%
                                   %{--class="descMultiRow"><strong>{{item.descripcion}}</strong></p>--}%
                            %{--</div>--}%
                        %{--</div>--}%

                        %{--<div ng-if="category.descripcion === 'Ingeniería en sitio' && category.selected">--}%
                            %{--<div class="col-sm-4">{{category.descripcion}}</div>--}%
                            %{--<div class="col-sm-8">--}%
                                %{--<div ng-repeat="tech in category.componentes">--}%%{--{{tech}}<br/>--}%
                                    %{--<span ng-if="tech.propiedades[0].valor > 0">--}%
                                        %{--{{tech.propiedades[0].valor + ' ' + tech.descripcion}}--}%
                                    %{--</span>--}%
                                    %{--<div ng-show="tech.arr && tech.arr.length > 0">--}%
                                        %{--<h5><em>{{tech.descripcion}}</em> {{tech.nItems}} dispositivos</h5>--}%
                                        %{--<div ng-repeat="item in tech.arr">--}%
                                            %{--<p ng-show="item && item.length > 0"><strong>{{tech.descripcion+' '+(+$index + 1)}}</strong>: {{item | printString:'descripcion'}}</p>--}%
                                        %{--</div>--}%
                                    %{--</div>--}%
                                %{--</div>--}%
                            %{--</div>--}%
                        %{--</div>--}%


                        %{--<div ng-show="category.descripcion === 'Tecnología' && category.selected" class="col-md-12">--}%%{--{{category.techSelected}}--}%
                            %{--<div class="col-sm-3">{{category.descripcion}}:</div>--}%
                            %{--<div class="col-sm-9">--}%
                                %{--<div ng-repeat="tech in category.componentes">--}%
                                    %{--<div ng-show="tech.arr && tech.arr.length > 0">--}%
                                        %{--<h5><em>{{tech.descripcion}}</em> {{tech.nItems}} dispositivos</h5>--}%
                                        %{--<div ng-repeat="item in tech.arr">--}%
                                            %{--<p ng-show="item && item.length > 0"><strong>{{tech.descripcion+' '+(+$index + 1)}}</strong>: {{item | printString:'descripcion'}}</p>--}%
                                        %{--</div>--}%
                                    %{--</div>--}%
                                %{--</div>--}%
                            %{--</div>--}%
                        %{--</div> --}%%{--{{category.selected}}--}%
                    %{--</div>--}%
                </div>

                <button type="button" class="btn btn-primary" ng-click="calcular()" ng-disabled="isReady()">Calcular
                </button>
            </div>
        </div>
    </div>

    <div class="col-md-12">
        <div ng-show="resultados">
            <h4>Número de tickets</h4>
            <p>
                Acontinuación se muestran los resultados de manera desglosada.
            </p>
            <p>
                La primera fila tiene la información 'base' de número de tickets. El registro (en BD) seleccionado
                coincide con todas o el mayor numero de 'dependencias' seleccionadas por el usuario.
            </p>
            <p>
                Las filas restantes mustran el resultado parcial obtenido al aplicar los factores coincidentes, de
                acuerdo a lo seleccionado por el usuario.
            </p>
            <p>
                La última fila es el resultado total.
            </p>
            <table class="table table-striped">
                <thead>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>CC</th>
                <th>ES</th>
                <th>RQ</th>
                <th>AS</th>
                </thead>
                <tbody>
                %{--<tr title="">--}%
                    %{--<td>{{resultados.best.nombre}}</td>--}%
                    %{--<td>{{resultados.best.descripcion}}</td>--}%
                    %{--<td>{{resultados.best.cc}}</td>--}%
                    %{--<td>{{resultados.best.es}}</td>--}%
                    %{--<td>{{resultados.best.rq}}</td>--}%
                    %{--<td>{{resultados.best.acs}}</td>--}%
                %{--</tr>--}%
                %{--<tr ng-repeat="res in resultados.modifiers"--}%
                    %{--ng-class="$last? 'success': ''"--}%
                    %{--title="{{res[0].factor}}">--}%
                    %{--<td>{{res[0].nombre}}</td>--}%
                    %{--<td>{{res[0].descripcion}}</td>--}%
                    %{--<td>{{res[0].cc}}</td>--}%
                    %{--<td>{{res[0].es}}</td>--}%
                    %{--<td>{{res[0].rq}}</td>--}%
                    %{--<td>{{res[0].acs}}</td>--}%
                %{--</tr>--}%
                </tbody>
            </table>
        </div>
        <div ng-show="noMatches()">
            Ninguna regla coincide para lo seleccionado
        </div>
    </div>

</div>

</body>
</html>
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
    %{--<asset:javascript src="bootstrap-switch.js"/>--}%
    %{--<asset:javascript src="angular/modules/angular-bootstrap-switch.ja"/>--}%
    <asset:javascript src="angular/modules/angular-toggle-switch.min.js"/>
    <asset:javascript src="ui-bootstrap-tpls-0.10.0.js"/>
    <asset:javascript src="calculadora.js"/>

    <asset:stylesheet src="angular-toggle-switch.css"/>

    <style>
    .descRow {
        margin-bottom: 6px;
    }

    .descMultiRow {
        margin-bottom: 0;
    }

    .itemsList {
        list-style-type: none;
    }
    .right-space {
        margin-right: 4px;
    }
    .bottom-space {
        margin-bottom: 5px;
    }
    .left-float {
        float: left;
    }
    .right-float {
        float: right !important;
    }
    .small-input {
        max-width: 90px;
    }
    .limit-size {
        max-width: 300px;
    }
    .min-width-x {
        min-width: 130px;
    }
    .up-space {
        margin-top: 10px;
    }
    .accordion-toggle {
        display: block;
    }
    .concepto, .conceptoC {
        display: block;
    }
    .concepto:hover {
        background-color: #eaeaea;
        color: #454545;
    }
    .max-width-80 {
        max-width: 80px;
    }
    .toggle-switch span {
        height: auto;
    }
    .toggle-switch {
        border-color: #bbbbbb;
    }
    /*.accordion-toggle:nth-child(2) {*/
        /*height: 32px;*/
    /*}*/
    /*a.accordion-toggle:nth-of-type(2) {*/
        /*height: 32px;*/
    /*}*/
    .panel-group > .panel-default:nth-child(2) a {
        height: 32px;
    }
    </style>
</head>

<body>
<div class="container-fluid row" ng-app="calculadora" ng-controller="calcularCtrl">
    <div class="col-md-6">

        <accordion close-others="oneAtATime">
            <accordion-group ng-repeat="category in categories" is-open="$parent.categoOpened[$index]">
                <accordion-heading ng-class="category.descripcion === 'Ingeniería en sitio'? 'alto': ''">
                    {{category.descripcion}}
                    %{--<input type="checkbox"--}%
                           %{--class="right-float"--}%
                           %{--bs-switch--}%
                           %{--ng-if="category.descripcion === 'Ingeniería en sitios'"/>--}%
                    %{--<toggle-switch--}%
                            %{--class=""--}%
                            %{--on-label="Sí"--}%
                            %{--off-label="No"--}%
                            %{--ng-model="$parent.categoOpened[$index]"--}%
                            %{--ng-if="category.descripcion === 'Ingeniería en sitio'"></toggle-switch>--}%
                    <toggle-switch
                            class="pull-right"
                            on-label="Sí"
                            off-label="No"
                            ng-model="category.selected"
                            ng-if="category.descripcion === 'Ingeniería en sitio'"></toggle-switch>
                </accordion-heading>


                <ul ng-if="category.descripcion === 'Tipo de cliente' && category.conceptos && category.conceptos.length > 0" class="itemsList">
                    <li ng-repeat="item in category.conceptos">
                        <label class="concepto">
                            <input ng-if="category.multiple" type="checkbox"
                                   name="{{category.id}}-concepto"
                                   checklist-model="category.selected"
                                   checklist-value="item"/>
                            <input ng-if="!category.multiple" type="radio"
                                   name="{{category.id}}-concepto"
                                   ng-model="category.selected"
                                   ng-value="item"/>
                            {{item.descripcion}}
                        </label>
                    </li>
                </ul>


                <div ng-if="category.descripcion === 'Ingeniería en sitio' && category.componentes">
                    <div class="form-group col-md-12">
                        %{--<input type="checkbox"--}%
                               %{--class="right-float"--}%
                               %{--bs-switch--}%
                               %{--ng-model="currentCatego.isYes"/>--}%
                        <toggle-switch
                               class="right-float"
                               on-label="Sí"
                               off-label="No"
                               ng-model="category.selected"></toggle-switch>
                    </div>
                    %{--<div class="form-inline bottom-space">--}%
                    <div class="form-group col-md-6">
                        <select ng-options="comp as comp.descripcion for comp in category.componentes"
                                ng-model="currentCatego.techSelected"
                                ng-change="showOptions(category)"
                                title="Elige una tecnología"
                                class="form-control input-sm">
                            <option>{{$parent}}</option></select>
                    </div>

                    <div class="form-group col-md-3">
                        <div class=""
                             ng-class="opt.descripcion === 'cantidad'? '': ''"
                             ng-repeat="opt in currentCatego.techSelected.propiedades">
                            <input type="number"
                                   class="form-control input-sm"
                                   placeholder="{{opt.descripcion}}"
                                   ng-class="opt.descripcion === 'cantidad'? 'small-input': ''"
                                   ng-show="['int', 'Integer'].indexOf(opt.tipo) > -1"
                                   ng-model="opt.valor"
                                   ng-change="registerQuantity(currentCatego.techSelected, opt)"/>
                            <select class="form-control input-sm limit-size" title=""
                                    ng-show="opt.descripcion == 'volumetría'">
                                <option>Small Bussiness hasta 500 usuarios</option>
                                <option>Medium Bussiness hasta 5,000 usuarios</option>
                                <option>Datacenters & Large Enterprise más de 5,000 usuarios</option>
                            </select>
                            <label ng-show="['check', 'boolean'].indexOf(opt.tipo) > -1">
                                <input type="checkbox" ng-model="opt.valor"/>
                                {{opt.descripcion}}
                            </label>
                        </div>
                    </div>
                    %{--</div>--}%

                </div>


                <div ng-if="category.descripcion === 'Tecnología' && category.componentes">
                    %{--<div class="form-inline bottom-space">--}%
                        <div class="form-group col-md-3">
                            <select ng-options="comp as comp.descripcion for comp in category.componentes"
                                    ng-model="currentCatego.techSelected"
                                    ng-change="showOptions(category)"
                                    title="Elige una tecnología"
                                    class="form-control input-sm">
                                <option>{{$parent}}</option></select>
                        </div>

                        <div class="form-group col-md-9">
                            <div class=""
                                 ng-class="opt.descripcion === 'cantidad'? 'col-xs-3': 'col-xs-9'"
                                 ng-repeat="opt in currentCatego.techSelected.propiedades">
                                <input type="number"
                                       class="form-control input-sm"
                                       placeholder="{{opt.descripcion}}"
                                       ng-class="opt.descripcion === 'cantidad'? 'small-input': ''"
                                       ng-show="['int', 'Integer'].indexOf(opt.tipo) > -1"
                                       ng-model="opt.valor"
                                       ng-change="lookForQuantity(currentCatego.techSelected, opt)"/>
                                <select class="form-control input-sm limit-size" title=""
                                        ng-show="opt.descripcion == 'volumetría'">
                                    <option>Small Bussiness hasta 500 usuarios</option>
                                    <option>Medium Bussiness hasta 5,000 usuarios</option>
                                    <option>Datacenters & Large Enterprise más de 5,000 usuarios</option>
                                </select>
                                <label ng-show="['check', 'boolean'].indexOf(opt.tipo) > -1">
                                    <input type="checkbox" ng-model="opt.valor"/>
                                    {{opt.descripcion}}
                                </label>
                            </div>
                        </div>
                    %{--</div>--}%

                    %{--<div class="form-group" ng-show="currentCatego.techSelected.auxArray.length > 0">--}%
                        <div class="form-group col-md-12" ng-show="currentCatego.techSelected.auxArray.length > 0">
                            <div class="col-sm-5">
                                <label>
                                    <input type="radio" name="applyTo" value="todos"
                                           ng-model="currentCatego.techSelected.deviceScope"/>Todos
                                </label>
                                <label>
                                    <input type="radio" name="applyTo" value="uno"
                                           ng-model="currentCatego.techSelected.deviceScope"/>Uno
                                </label>
                                <label>
                                    <input type="radio" name="applyTo" value="varios"
                                           ng-model="currentCatego.techSelected.deviceScope"/>Varios
                                </label>
                            </div>
                            <div class="right-float col-xs-12 col-sm-6">
                                <select ng-show="currentCatego.techSelected.deviceScope === 'uno'"
                                        ng-init="currentCatego.techSelected.currentItem = currentCatego.techSelected.auxArray[0]"
                                        ng-options="idx as currentCatego.techSelected.descripcion+' '+idx for idx in currentCatego.techSelected.auxArray"
                                        ng-model="currentCatego.techSelected.currentItem"
                                        ng-change="algo(currentCatego.techSelected, currentCatego.techSelected.conceptos,  currentCatego.techSelected.currentItem, currentCatego.techSelected.arr)"
                                        class="form-control input-sm min-width-x"
                                        title="Elige uno para modificar sus opciones"></select>
                                <input type="number" placeholder="#" class="form-control input-sm max-width-801"
                                       ng-show="currentCatego.techSelected.deviceScope === 'varios'"/>
                            </div>
                        %{--</div>--}%
                    </div>    %{--{{currentCatego.techSelected.arr}}--}%

                    <div ng-show="currentCatego.techSelected.currentItem > 0">
                        <div class="col-md-4"
                             ng-repeat="item in currentCatego.techSelected.conceptos">
                            <label class="conceptoC">
                                <input type="checkbox"
                                       name="{{category.id}}-concepto"
                                       checklist-model="currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1]"
                                       ng-change="updateCatego(currentCatego.techSelected.arr[currentCatego.techSelected.currentItem-1])"
                                       checklist-value="item"/>
                                {{item.descripcion}}
                            </label>
                        </div>    %{--{{currentCatego.techSelected.arr}}--}%
                    <div class="col-md-12 btn-group">
                        <a href="#" class="btn right-float" ng-disabled="currentCatego.techSelected.deviceScope == 'todos'"><span class="glyphicon glyphicon-paste"></span> Pegar</a>
                        <a href="#" class="btn right-float" ng-disabled="currentCatego.techSelected.deviceScope == 'todos'"><span class="glyphicon glyphicon-copy"></span> Copiar</a>
                        <a href="#" class="right-float btn" ng-click="selectNone(currentCatego.techSelected)"><span class="glyphicon glyphicon-unchecked"></span> Ninguno</a>
                        <a href="#" class="right-float btn" ng-click="selectAll(currentCatego.techSelected)"><span class="glyphicon glyphicon-ok"></span> Todos</a>
                    </div>
                    </div>
                </div>
            </accordion-group>
        </accordion>
    </div>


    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-body">
                <div >
                    <h3>Resumen general</h3>
                    %{--<h5>--}%%{--{{categoOpened}} --}%%{--  {{currentCatego.descripcion}}</h5>--}%

                    <div ng-repeat="category in categories">
                        <div ng-if="category.descripcion !== 'Tecnología' && category.descripcion !== 'Ingeniería en sitio' && category.selected && !category.multiple" class="col-md-12 descRow">
                            <div class="col-sm-3">{{category.descripcion}}:</div>

                            <div class="col-sm-9"><strong>{{category.selected.descripcion}}</strong></div>
                        </div>

                        <div ng-if="category.descripcion !== 'Tecnología' && category.descripcion !== 'Ingeniería en sitio' && category.selected && category.selected.length>0 && category.multiple"
                             class="col-md-12 descRow">
                            <div class="col-sm-3">{{category.descripcion}}</div>

                            <div class="col-sm-9">
                                <p ng-repeat="item in category.selected"
                                   class="descMultiRow"><strong>{{item.descripcion}}</strong></p>
                            </div>
                        </div>

                        <div ng-if="category.descripcion === 'Ingeniería en sitio' && category.selected">
                            <div class="col-sm-4">{{category.descripcion}}</div>
                            <div class="col-sm-8">
                                <div ng-repeat="tech in category.componentes">%{--{{tech}}<br/>--}%
                                    <span ng-if="tech.propiedades[0].valor > 0">
                                        {{tech.propiedades[0].valor + ' ' + tech.descripcion}}
                                    </span>
                                    %{--<div ng-show="tech.arr && tech.arr.length > 0">--}%
                                        %{--<h5><em>{{tech.descripcion}}</em> {{tech.nItems}} dispositivos</h5>--}%
                                        %{--<div ng-repeat="item in tech.arr">--}%
                                            %{--<p ng-show="item && item.length > 0"><strong>{{tech.descripcion+' '+(+$index + 1)}}</strong>: {{item | printString:'descripcion'}}</p>--}%
                                        %{--</div>--}%
                                    %{--</div>--}%
                                </div>
                            </div>
                        </div>


                        <div ng-show="category.descripcion === 'Tecnología' && isOk(category.techSelected)" class="col-md-12">%{--{{category.techSelected}}--}%
                            <div class="col-sm-3">{{category.descripcion}}:</div>
                            <div class="col-sm-9">
                                <div ng-repeat="tech in category.componentes">
                                    <div ng-show="tech.arr && tech.arr.length > 0">
                                        <h5><em>{{tech.descripcion}}</em> {{tech.nItems}} dispositivos</h5>
                                        <div ng-repeat="item in tech.arr">
                                            <p ng-show="item && item.length > 0"><strong>{{tech.descripcion+' '+(+$index + 1)}}</strong>: {{item | printString:'descripcion'}}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> %{--{{category.selected}}--}%
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

%{--<asset:deferredScripts/>--}%
</body>
</html>
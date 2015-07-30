<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 16/06/2015
  Time: 06:36 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-backoffice">
    <asset:javascript src="cms.js"/>
    <title>CMS</title>

    <style>
        .btn-add-prop {
            float: right;
        }
        .new-prop-btns {}
    </style>
</head>

<body>

<div ng-app="cms" ng-controller="cmsCtrl">
    %{--<div class="row" ng-controller="listasCtrl">--}%
        <div class="col-md-12">
            <ol class="breadcrumb">
                <li>
                    <a href="" ng-if="tree.length > 0" ng-click="resetView()">Todos</a>
                    <span ng-if="!(tree.length > 0)">Todos</span> </li>
                <li ng-repeat="item in tree" ng-class="{'active':$last}">
                    <a href="" ng-click="showChildren(item)" ng-if="!$last">{{item.customId}}</a>
                    <span ng-if="$last">{{item.customId}}</span> </li>
            </ol>
        </div>




        <div ng-class="selected.nodeType == 'LEAF'? 'col-md-12': 'col-md-8'" ng-show="tree.length > 0">
            <div class="panel panel-default">
                <div
                        class="panel-heading"><h4>Datos de {{selected
                .customId}}<small class="pull-right">{{selected.domainClass}} ({{selected.nodeType}})</small></h4></div>
                <div class="panel-body">
                    <div ng-if="selected.nodeType == 'ROOT'">
                        <div class="form-group">
                            <label for="descInpt" class="control-label">Descripción</label>
                            <input type="text" class="form-control" id="descInpt" ng-model="selected.descripcion"/>
                        </div>
                    </div>
                    <div ng-if="selected.nodeType == 'LEAF'">
                        <div class="form-group">
                            <label for="descInpt2" class="control-label">Descripción</label>
                            <input type="text" class="form-control" id="descInpt2" ng-model="selected.descripcion"/>
                        </div>
                        <div class="form-group">
                            <label for="costoInpt" class="control-label">Costo</label>
                            <input type="number" class="form-control" id="costoInpt" ng-model="selected.costo"/>
                        </div>
                    </div>
                    <div ng-if="selected.nodeType == 'BRANCH'">
                        <div class="form-group" ng-repeat="prop in selected.propiedades">
                            %{--<label for="propDesc-{{$index}}" class="control-label">Descripción</label>--}%
                            %{--<input type="text" class="form-control" id="propDesc-{{$index}}" ng-model="prop.descripcion"/>--}%
                            %{--<label for="propType-{{$index}}" class="control-label">Tipo</label>--}%
                            %{--<input type="text" class="form-control" id="propType-{{$index}}" ng-model="prop.tipo"/>--}%
                            Propiedad <strong>{{prop.descripcion}}</strong> es de tipo <em>{{prop.tipo}}</em>
                        </div>
                    </div>

                    <div class="col-md-12" ng-if="selected.nodeType == 'BRANCH'">
                        <button class="btn btn-default btn-sm btn-add-prop" ng-click="showPropForm()" ng-hide="newProperty">Nueva propiedad</button>
                    </div>
                    <div ng-if="newProperty">
                        <div class="form-group">
                            <label for="propDesc" class="control-label">Descripción</label>
                            <input type="text" class="form-control" id="propDesc" ng-model="newPropDescripcion"/>
                        </div>
                        <div class="form-group">
                            <label for="propType" class="control-label">Tipo</label>
                            <input type="text" class="form-control" id="propType" ng-model="newPropTipo"/>
                        </div>
                        <div class="btn-group new-prop-btns">
                            <button class="btn btn-default btn-sm btn-add-prop" ng-click="addProp(selected)">Agregar</button>
                            <button class="btn btn-default btn-sm btn-add-prop" ng-click="cancelProp()">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>






        <div class="col-md-4" ng-if="selected.nodeType != 'LEAF'">
            <div class="list-group">
                <div class="list-group-item">
                <div class="list-group-item-heading">
                    <h4 class="text-center">
                        {{selected? 'Hijos de '+selected.customId: 'Todas las categorías'}}
                    </h4>
                </div>
                </div>
                <div ng-repeat="child in childrens" class="col-sm-12 list-group-item"
                     ng-class="$last? 'spaced-bottom': ''">
                    <a href="" class="col-sm-10"
                       ng-click="showChildren(child)">
                        {{child.descripcion}} <small class="pull-right">&lt{{child.domainClass}}&gt</small>
                    </a>
                    <a href=""
                       ng-click="removeChild($index)"
                       class="btn btn-default col-sm-2">
                        <i class="glyphicon glyphicon-trash"></i> </a>
                </div>

                <div class="list-group-item-header">
                    <h4 class="text-center list-group-item-success"
                        style="padding-bottom: 10px; margin-top: 10px; margin-bottom: 0;">Nuevo
                    elemento</h4>
                    <form class="form" novalidate name="newItemForm">
                        <div class=""
                             ng-show="selected && selected.domainClass !== 'Concepto' && selected.domainClass !== 'Propiedad'">
                            <label>
                                <input type="radio" name="domainType" value="concepto" checked required
                                       ng-model="$parent.domainType">Concepto
                            </label>
                            <label>
                                <input type="radio" name="domainType" value="componente" required
                                       ng-model="$parent.domainType">Componente
                            </label>
                        </div>
                        <div class=""
                             ng-class="{'has-error': newItemForm.nombre.$invalid && newItemForm.nombre.$dirty}">
                        <input placeholder="nombre (sin espacios)"
                               name="nombre"
                               required
                               class="form-control"
                               ng-model="$parent.customId">
                            <span ng-show="newItemForm.nombre.$dirty && newItemForm.nombre.$error.required"
                                  class="help-block text-danger">Requerido</span>
                        </div>
                        <div class=""
                             ng-class="{'has-error': newItemForm.descripcion.$invalid && newItemForm.descripcion.$dirty}">
                        <input type="text"
                               placeholder="descripción"
                               name="descripcion"
                               required
                               class="form-control"
                               ng-model="$parent.descripcion">
                            <span ng-show="newItemForm.descripcion.$dirty && newItemForm.descripcion.$error.required"
                                  class="help-block text-danger">Requerido</span>
                        </div>
                        <button type="submit" class="btn btn-default form-control"
                                ng-click="addItem()" ng-disabled="newItemForm.$invalid"><span
                                class="glyphicon glyphicon-plus"></span> Agregar
                        </button>
                    </form>
                </div>
            </div>
        </div>

    <div class="col-md-8" ng-if="!selected">
        <p>Elige un elemento para editar sus propiedades y administrar sus 'hijos'</p>
        <p>Los elementos forman una estructura de arbol. Existen 4 tipos de nodos:</p>
        <ol>
            <li><strong>Categoria</strong> Es el nodo raiz de un 'grupo' de elementos con alguna relación estrecha
            . Puede tener hijos ConceptoEspecial y Concepto</li>
            <li><strong>ConceptoEspecial</strong> Estos nodos son intermedios y sirven como contenedores de otros
            nodos que son los que definen propiedades y demás, no pueden ser nodos raíz ni hoja.
            Se les puede asignar propiedades 'especiales', por ejemplo la cantidad de dispositivos, que afectan a
            todos sus nodos hijos. Puede tener hijos: Concepto y Propiedad.</li>
            <li><strong>Propiedad</strong> Solo pueden ser hijos de ConceptoEspecial. Cada uno de estos nodos
            representa alguna característica, por ejemplo la cantidad de dispositivos.</li>
            <li><strong>Concepto</strong> Son nodos hoja, por ejemplo los servicios de un firewall</li>
        </ol>
    </div>

</div>

</body>
</html>
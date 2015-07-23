<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 07/07/2015
  Time: 06:27 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-backoffice">
    %{--<meta name="layout" content="main-layout">--}%

    %{--<asset:javascript src="angular/angular.js"/>--}%
    %{--<asset:javascript src="angular/modules/checklist-model.js"/>--}%
    %{--<asset:javascript src="bootstrap-switch.js"/>--}%
    %{--<asset:javascript src="angular/modules/angular-bootstrap-switch.ja"/>--}%
    %{--<asset:javascript src="angular/modules/angular-toggle-switch.min.js"/>--}%
    %{--<asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>--}%
    %{--<asset:javascript src="calculadora.js"/>--}%

    <script>var ticketId = null;</script>
    <title>backoffice ${section?: ''}</title>
    <style>
    </style>
</head>

<body>
%{--<div ng-app="calculadora" ng-controller="calcularCtrl">--}%
    %{--<pagination direction-links="false" boundary-links="true" total-items="64"--}%
                %{--ng-model="currentPage"></pagination>--}%
%{--</div>--}%
<div ng-app="backoffice" ng-controller="ticketCtrl">

    <div class="row col-md-12 form-group">
    <div class="col-md-1"><span class="control-label">Filtrar por</span> </div>
    <div class="col-md-3">
        <input type="text"
               id="searchbox"
               ng-model="search"
               ng-change="filter()"
               placeholder="Palabra/Frase clave"
               class="form-control">
    </div>
</div>

    <div class="row">
        <div class="col-md-12" ng-show="filteredItems > 0">
            <table class="table table-stripped table-bordered">
                <thead>
                <th>Nombre<a ng-click="sort_by('nombre');"><i class="glyphicon glyphicon-sort"></i> </a> </th>
                <th>Descripción<a ng-click="sort_by('descripcion');"><i class="glyphicon glyphicon-sort"></i> </a> </th>
                </thead>
                <tbody>
                <tr
                        ng-repeat="data in filtered = (ticketList | filter:search | orderBy :predicate :reverse) | startFrom:(currentPage-1)*entryLimit | limitTo:entryLimit">
                    <td>{{data.nombre}}</td>
                    <td>{{data.descripcion}}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="col-md-12" ng-show="filteredItems == 0">
            <div class="col-md-12">
                <h4>No se han encontrado registros</h4>
            </div>
        </div>
        <div class="col-md-12" ng-show="filteredItems > 0">
            <pagination
                 ng-model="currentPage"
                 boundary-links="true"
                 total-items="filteredItems"
                 items-per-page="entryLimit"
                 class="pagination-small"
                 first-text="Inicio"
                 last-text="Fin"
                 previous-text="<<"
                 next-text=">>"></pagination>
        </div>
    </div>

</div>
</body>
</html>
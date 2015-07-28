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
    <script>var ticketId = null;</script>
    <title>backoffice ${section?: ''}</title>
    <style>
    </style>
</head>

<body>
<div ng-app="backoffice" ng-controller="factorCtrl">
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
            <table class="table table-striped table-bordered">
                <thead>
                <th>Nombre<a ng-click="sort_by('nombre');"><i class="glyphicon glyphicon-sort"></i> </a> </th>
                <th>Descripción<a ng-click="sort_by('descripcion');"><i class="glyphicon glyphicon-sort"></i> </a> </th>
                </thead>
                <tbody>
                <tr
                        ng-repeat="data in filtered = (factorList | filter:search | orderBy :predicate :reverse) | startFrom:(currentPage-1)*entryLimit | limitTo:entryLimit">
                    <td><a href="factor/{{data.id}}"> {{data.nombre}}</a></td>
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
            <div pagination=""
                 ng-model="currentPage"
                 on-select-page="setPage(currentPage)"
                 boundary-links="true"
                 total-items="filteredItems"
                 items-per-page="entryLimit"
                 max-size="15"
                 class="pagination-small"
                 first-text="Inicio"
                 last-text="Fin"
                 previous-text="&laquo;"
                 next-text="&raquo;">
            </div>
        </div>
    </div>
</div>
</body>
</html>
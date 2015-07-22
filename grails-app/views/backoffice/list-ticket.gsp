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
    %{--<asset:javascript src="angular/angular.js"/>--}%
    %{--<asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>--}%
    <script>var ticketId = null;</script>
    <asset:javascript src="backoffice.js"/>
    <title>backoffice ${section?: ''}</title>
    <style>
    </style>
</head>

<body>
<div ng-app="backoffice" ng-controller="ticketCtrl">
    <table class="table table-stripped table-bordered">
        <thead>
        <th>Nombre</th>
        <th>Descripción</th>
        %{--<th>Dependencias</th>--}%
        </thead>
        <tbody>
        <tr ng-repeat="rule in ticketList">
            <td><a href="ticket/{{rule.id}}">{{rule.nombre}}</a> </td>
            <td>{{rule.descripcion}}</td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
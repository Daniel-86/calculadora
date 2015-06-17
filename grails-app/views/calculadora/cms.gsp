<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 16/06/2015
  Time: 06:36 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-layout">
    <asset:javascript src="angular/angular.js"/>
    <asset:javascript src="ui-bootstrap-tpls-0.10.0.js"/>
    <asset:javascript src="cms.js"/>
    <title>CMS</title>
</head>

<body>

<div class="container" ng-app="cms" ng-controller="cmsCtrl">
    <div class="row" ng-controller="listasCtrl">
        <div class="col-md-4">
            <div class="list-group">
                <a href="#" class="list-group-item" ng-repeat="category in categories" ng-click="showChildren(category)">{{category.descripcion}}</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 30/06/2015
  Time: 12:30 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Calculadora de Servicios Administrados : Scitum - <g:layoutTitle/></title>
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="ng-sortable.style.css"/>
    <asset:stylesheet src="ng-sortable.css"/>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <asset:javascript src="angular/angular.js"/>
    %{--<asset:javascript src="angular/angular-1.3.js"/>--}%
    <asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>
    %{--<asset:javascript src="cms.js"/>--}%
    <asset:javascript src="backoffice.js"/>

    <base href="/calculadora/"/>

    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-default">
    <div class="container-fluid">
        <calculadora:header/>
    </div><!-- /.container-fluid -->
</nav>

<div class="container-fluid">

    <div class="row">
        <div class="col-md-12">

            <div class="animate-view" ng-view></div>
            <g:layoutBody/>
        </div>
    </div>
</div>


<g:render template="/backoffice/templates/footer"/>

</body>
</html>
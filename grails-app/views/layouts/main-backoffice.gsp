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

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <asset:javascript src="angular/angular.js"/>
    <asset:javascript src="ui-bootstrap-tpls-0.12.0.js"/>
    <asset:javascript src="cms.js"/>

    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" target="_blank" href="https://www.scitum.com.mx">
                <asset:image src="logoScitum_MR_300x120px.png" style="display:inline" height="40" alt="Scitum"/>
                %{--<img alt="Scitum" style="display:inline" height="40" src="img/logoScitum_MR_300x120px.png"> --}%
            </a>
        <g:link uri="/">Home</g:link>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a class="center-block" href="#"><span class="lead ">Calculadora de Servicios Administrados </span></a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Administración <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#">Tecnologías</a></li>
                            <li><a href="#">Fabricantes</a></li>
                            <li><a href="#">Servicios Administrados</a></li>
                            <li><g:link controller="backoffice" action="list"
                                        params="[section: 'ticket']">Tabla de tickets</g:link></li>
                            <li><g:link controller="calculadora" action="cms">CMS</g:link></li>
                            <li class="divider"></li>
                            <li><a href="#">SLAs</a></li>
                        </ul>
                    </li>
                </sec:ifAllGranted>
                <sec:ifLoggedIn>
                    <li><g:link controller="logout" action="index">Logout</g:link> </li>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <li><g:link controller="login" action="index">Login</g:link> </li>
                </sec:ifNotLoggedIn>
            </ul>
        </div><!-- /.navbar-collapse -->
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


<footer class="footer">
    <div class="container">
        <p class="text-muted">© 2015 - Scitum, S.A. de C.V. Todos los derechos reservados </p>
    </div>
</footer>

</body>
</html>
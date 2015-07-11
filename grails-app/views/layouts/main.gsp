<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Calculadora"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>

%{--<body id="ng-app" ng-app="${pageProperty(name: 'body.ng-app') ?: 'grails'}">--}%

%{--<div class="container-fluid">--}%

    %{--<nav class="navbar navbar-default" role="navigation">--}%
        %{--<div class="container-fluid">--}%
            %{--<div class="navbar-header">--}%
                %{--<g:link uri="/" class="navbar-brand">Angular Grails</g:link>--}%
            %{--</div>--}%
            %{--<ul class="nav navbar-nav navbar-left">--}%
                %{--<li><g:link uri="/"><i class="fa fa-home"></i> Home</g:link></li>--}%
                %{--<g:each var="c"--}%
                        %{--in="${grailsApplication.controllerClasses.findAll { it.logicalPropertyName != 'assets' }.sort {--}%
                            %{--it.fullName--}%
                        %{--}}">--}%
                    %{--<li><a href="${c.logicalPropertyName}"><i--}%
                            %{--class="fa fa-database"></i> ${c.logicalPropertyName.capitalize()} List</a></li>--}%
                %{--</g:each>--}%
            %{--</ul>--}%
        %{--</div>--}%
    %{--</nav>--}%
%{--</div>--}%

%{--<div class="container-fluid">--}%

    %{--<div class="row">--}%
        %{--<div class="col-md-12">--}%

            %{--<div class="animate-view" ng-view></div>--}%
            %{--<g:layoutBody/>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

%{--<asset:script type="text/javascript">--}%
    %{--angular.module('grails.constants')--}%
        %{--.constant('rootUrl', '${request.contextPath}')--}%
        %{--.constant('pageSize', ${grailsApplication.config.angular.pageSize})--}%
        %{--.constant('dateFormat', '${grailsApplication.config.angular.dateFormat}');--}%
%{--</asset:script>--}%

%{--<asset:javascript src="application.js"/>--}%
%{--<asset:deferredScripts/>--}%
%{--<g:pageProperty name="page.scripts" default=""/>--}%
%{--</body>--}%

<body>
<sec:ifLoggedIn>ESTOY LOGUEADO</sec:ifLoggedIn>
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

        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a class="center-block" href="#"><span class="lead ">Calculadora de Servicios Administrados </span></a></li>
            </ul>

            %{--<ul class="nav navbar-nav navbar-right">--}%
                %{--<li class="dropdown">--}%
                    %{--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Administración <span class="caret"></span></a>--}%
                    %{--<ul class="dropdown-menu" role="menu">--}%
                        %{--<li><a href="#">Tecnologías</a></li>--}%
                        %{--<li><a href="#">Fabricantes</a></li>--}%
                        %{--<li><a href="#">Servicios Administrados</a></li>--}%
                        %{--<li><g:link controller="backoffice" action="list"--}%
                                    %{--params="[section: 'ticket']">Tabla de tickets</g:link></li>--}%
                        %{--<li><g:link controller="calculadora" action="cms">CMS</g:link></li>--}%
                        %{--<li class="divider"></li>--}%
                        %{--<li><a href="#">SLAs</a></li>--}%
                    %{--</ul>--}%
                %{--</li>--}%
                %{--<li><a href="#">Logout</a></li>--}%
            %{--</ul>--}%
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

%{--<div class="container">--}%
<g:layoutBody/>
%{--</div>--}%


<footer class="footer">
    <div class="container">
        <p class="text-muted">© 2015 - Scitum, S.A. de C.V. Todos los derechos reservados </p>
    </div>
</footer>

</body>
</html>

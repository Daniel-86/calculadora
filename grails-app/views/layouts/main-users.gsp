<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 30/06/2015
  Time: 12:30 PM
--%>

<%@ page import="grails.util.Holders; grails.plugin.springsecurity.SpringSecurityUtils" contentType="text/html;charset=UTF-8" %>
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
    <s2ui:resources module='spring-security-ui' />

    %{--<base href="/calculadora/">--}%

    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-default">
    <div class="container-fluid">
        <calculadora:header/>
    </div><!-- /.container-fluid -->
</nav>

<div>

    <ul class="jd_menu jd_menu_slate">

        <li><g:link controller="user" action='search'>Buscar usuario</g:link></li>
        <li><g:link controller="user" action='create'>Nuevo usuario</g:link></li>
        <sec:ifAllGranted roles="ROLE_GOD">
            <li><g:link controller="role" action='search'>Roles</g:link></li>
            <li><g:link controller="role" action='create'>Nuevo rol</g:link></li>

            %{--<li class="dropdown">--}%
                %{--<a href="#" class="accessible dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><g:message--}%
                        %{--code="spring.security.ui.menu.appinfo"/></a>--}%
                %{--<ul class="dropdown-menu" role="menu">--}%
                    %{--<li><g:link action='config' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.config'/></g:link></li>--}%
                    %{--<li><g:link action='mappings' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.mappings'/></g:link></li>--}%
                    %{--<li><g:link action='currentAuth' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.auth'/></g:link></li>--}%
                    %{--<li><g:link action='usercache' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.usercache'/></g:link></li>--}%
                    %{--<li><g:link action='filterChain' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.filters'/></g:link></li>--}%
                    %{--<li><g:link action='logoutHandler' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.logout'/></g:link></li>--}%
                    %{--<li><g:link action='voters' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.voters'/></g:link></li>--}%
                    %{--<li><g:link action='providers' controller='securityInfo'><g:message code='spring.security.ui.menu.appinfo.providers'/></g:link></li>--}%
                %{--</ul>--}%
            %{--</li>--}%
        </sec:ifAllGranted>


        %{--<li class="dropdown"><a href="#" class="accessible dropdown-toggle" data-toggle="dropdown" role="button"--}%
               %{--aria-expanded="false"><g:message code="spring.security.ui.menu.users"/></a>--}%
            %{--<ul class="dropdown-menu" role="menu">--}%
                %{--<li><g:link controller="user" action='search'><g:message code="spring.security.ui.search"/></g:link></li>--}%
                %{--<li><g:link controller="user" action='create'><g:message code="spring.security.ui.create"/></g:link></li>--}%
            %{--</ul>--}%
        %{--</li>--}%
    </ul>

    <div id='s2ui_header_body'>

        <div id='s2ui_header_title'>
            Spring Security Management Console
        </div>

    </div>

</div>

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
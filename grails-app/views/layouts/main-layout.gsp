<%--
  Created by IntelliJ IDEA.
  User: daniel.jimenez
  Date: 15/06/2015
  Time: 01:42 PM
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

        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a class="center-block" href="#"><span class="lead ">Calculadora de Servicios Administrados </span></a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Administración <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Tecnologías</a></li>
                        <li><a href="#">Fabricantes</a></li>
                        <li><a href="#">Servicios Administrados</a></li>
                        <li><g:link controller="calculadora" action="cms">CMS</g:link></li>
                        <li class="divider"></li>
                        <li><a href="#">SLAs</a></li>
                    </ul>
                </li>
                <li><a href="#">Logout</a></li>
            </ul>
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

%{--<asset:javascript src="application.js"/>--}%
%{--<asset:deferredScripts/>--}%



%{--<script>--}%
    %{--$.noConflict();--}%
    %{--jQuery( document ).ready(function( $ ) {--}%

        %{--var war = $('.accordion-toggle');   --}%
        %{--console.log('asdfasdf', war);--}%
        %{--$.each(war, function(a,d) {console.log(d);});--}%
        %{--// Code that uses jQuery's $ can follow here.--}%
%{--//        var anchors = document.querySelectorAll(".accordion-toggle"), i;--}%
%{--//        for(i=0; i<anchors.length; i++) {--}%
%{--//            console.log('asdf  ',anchors[i]);--}%
%{--//            anchors[i].href = "#";--}%
%{--//        }--}%
    %{--});--}%
%{--</script>--}%

</body>
</html>
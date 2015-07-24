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

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <base href="/calculadora/"/>

    <g:layoutHead/>
</head>

<body>
%{--<script src="http://html5shim.googlecode.com/svm/trun/html5.js"></script>--}%
%{--<script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>--}%



%{--<sec:ifLoggedIn>ESTOY LOGUEADO<p><sec:username/></p></sec:ifLoggedIn>--}%
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <calculadora:header/>
    </div><!-- /.container-fluid -->
</nav>

%{--<div class="container">--}%
    <g:layoutBody/>
%{--</div>--}%


<g:render template="/backoffice/templates/footer"/>

</body>
</html>
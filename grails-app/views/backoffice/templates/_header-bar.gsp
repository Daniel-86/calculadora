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
        <li>
            <g:link uri="/" class="center-block">
                <span class="lead ">Calculadora de Servicios Administrados
                </span>
            </g:link></li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
        <sec:ifAllGranted roles="ROLE_ADMIN">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Administración <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                    <sec:ifAllGranted roles="ROLE_GOD"><li><g:link controller="user">Usuarios</g:link></li></sec:ifAllGranted>
                    <li><g:link uri="/factores">Factores</g:link></li>
                    <li><g:link uri="/tickets"
                                params="[section: 'ticket']">Tabla de tickets</g:link></li>
                    <li><g:link controller="calculadora" action="cms">CMS</g:link></li>
                    %{--<li class="divider"></li>--}%
                    %{--<li><a href="#">SLAs</a></li>--}%
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
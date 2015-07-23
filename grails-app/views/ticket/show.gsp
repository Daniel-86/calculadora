
<%@ page import="mx.com.scitum.Ticket" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ticket.label', default: 'Ticket')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ticket" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ticket" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ticket">
			
				<g:if test="${ticketInstance?.descripcion}">
				<li class="fieldcontain">
					<span id="descripcion-label" class="property-label"><g:message code="ticket.descripcion.label" default="Descripcion" /></span>
					
						<span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${ticketInstance}" field="descripcion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ticketInstance?.acs}">
				<li class="fieldcontain">
					<span id="acs-label" class="property-label"><g:message code="ticket.acs.label" default="Acs" /></span>
					
						<span class="property-value" aria-labelledby="acs-label"><g:fieldValue bean="${ticketInstance}" field="acs"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ticketInstance?.cc}">
				<li class="fieldcontain">
					<span id="cc-label" class="property-label"><g:message code="ticket.cc.label" default="Cc" /></span>
					
						<span class="property-value" aria-labelledby="cc-label"><g:fieldValue bean="${ticketInstance}" field="cc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ticketInstance?.dependencias}">
				<li class="fieldcontain">
					<span id="dependencias-label" class="property-label"><g:message code="ticket.dependencias.label" default="Dependencias" /></span>
					
						<g:each in="${ticketInstance.dependencias}" var="d">
						<span class="property-value" aria-labelledby="dependencias-label"><g:link controller="item" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${ticketInstance?.es}">
				<li class="fieldcontain">
					<span id="es-label" class="property-label"><g:message code="ticket.es.label" default="Es" /></span>
					
						<span class="property-value" aria-labelledby="es-label"><g:fieldValue bean="${ticketInstance}" field="es"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ticketInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="ticket.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${ticketInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ticketInstance?.rq}">
				<li class="fieldcontain">
					<span id="rq-label" class="property-label"><g:message code="ticket.rq.label" default="Rq" /></span>
					
						<span class="property-value" aria-labelledby="rq-label"><g:fieldValue bean="${ticketInstance}" field="rq"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:ticketInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${ticketInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

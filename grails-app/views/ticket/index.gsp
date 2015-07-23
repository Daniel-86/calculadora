
<%@ page import="mx.com.scitum.Ticket" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ticket.label', default: 'Ticket')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-ticket" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-ticket" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="descripcion" title="${message(code: 'ticket.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="acs" title="${message(code: 'ticket.acs.label', default: 'Acs')}" />
					
						<g:sortableColumn property="cc" title="${message(code: 'ticket.cc.label', default: 'Cc')}" />
					
						<g:sortableColumn property="es" title="${message(code: 'ticket.es.label', default: 'Es')}" />
					
						<g:sortableColumn property="nombre" title="${message(code: 'ticket.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="rq" title="${message(code: 'ticket.rq.label', default: 'Rq')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${ticketInstanceList}" status="i" var="ticketInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${ticketInstance.id}">${fieldValue(bean: ticketInstance, field: "descripcion")}</g:link></td>
					
						<td>${fieldValue(bean: ticketInstance, field: "acs")}</td>
					
						<td>${fieldValue(bean: ticketInstance, field: "cc")}</td>
					
						<td>${fieldValue(bean: ticketInstance, field: "es")}</td>
					
						<td>${fieldValue(bean: ticketInstance, field: "nombre")}</td>
					
						<td>${fieldValue(bean: ticketInstance, field: "rq")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${ticketInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>

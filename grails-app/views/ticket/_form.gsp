<%@ page import="mx.com.scitum.Ticket" %>



<div class="fieldcontain ${hasErrors(bean: ticketInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="ticket.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" value="${ticketInstance?.descripcion}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ticketInstance, field: 'acs', 'error')} required">
	<label for="acs">
		<g:message code="ticket.acs.label" default="Acs" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="acs" type="number" value="${ticketInstance.acs}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ticketInstance, field: 'cc', 'error')} required">
	<label for="cc">
		<g:message code="ticket.cc.label" default="Cc" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="cc" type="number" value="${ticketInstance.cc}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ticketInstance, field: 'dependencias', 'error')} ">
	<label for="dependencias">
		<g:message code="ticket.dependencias.label" default="Dependencias" />
		
	</label>
	<g:select name="dependencias" from="${mx.com.scitum.Item.list()}" multiple="multiple" optionKey="id" size="5" value="${ticketInstance?.dependencias*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ticketInstance, field: 'es', 'error')} required">
	<label for="es">
		<g:message code="ticket.es.label" default="Es" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="es" type="number" value="${ticketInstance.es}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ticketInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="ticket.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${ticketInstance?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ticketInstance, field: 'rq', 'error')} required">
	<label for="rq">
		<g:message code="ticket.rq.label" default="Rq" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rq" type="number" value="${ticketInstance.rq}" required=""/>

</div>


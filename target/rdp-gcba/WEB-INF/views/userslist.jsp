<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="header.jsp"%>
<html>

<body>
	<main class="main-container no-padding-top" role="main">
	<section>

		<nav class="navbar navbar-default" role="navigation">
			<div class="container">
				<div class="row">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#main-nav">
							<span class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#" title="Registro de Parque Informático">RDP</a>
					</div>
					<div class="collapse navbar-collapse" id="main-nav">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="<c:url value='/bienvenido/' />">Volver</a></li>						
							<li><a href="<c:url value='/abm-usuarios-rdp/alta-de-usuario' />">Agregar Usuario</a></li>
							<li><a href="<c:url value='/editar/editar-perfil/' />"><span class="glyphicon glyphicon-user"></span> ${usuario.firstName} ${usuario.lastName} </a></li>
							<li><a href="<c:url value='/index' />"><span class="glyphicon glyphicon-log-in"></span> Salir</a></li>
						</ul>
					</div>
				</div>
			</div>
		</nav>
		
		<c:choose>
			<c:when test="${param.accion}">
				<div class="container">
					<div class="col-xs-12">
						<div class="alert-spot alert-spot-success">
							<div class="alert-link-text">
								<h4>${param.success}</h4>
							</div>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>

		<div class="container">
			<div class="panel-group">
				<div class="panel panel-primary">
					<div class="panel-heading ">
						<b>Listado de Usuarios</b>
					</div>

					<div class="panel-body">
						<table class="table table-striped table-bordered nowrap cargando" cellspacing="0" width="100%" id="users">
							<thead>
								<tr>
									<th></th>
									<th>Nombre</th>
									<th>Apellido</th>
									<th>Email</th>
									<th>SSO ID</th>
								</tr>
							</thead>									
						</table>
					</div>
				</div>
			</div>
		</div>
			
	<!-- 		<div class="panel-group">
				<div class="panel-body">
					<div class="well floatRight"></div>
				</div>
			</div>
		</div>
 -->

	</section>
	</main>
	<spring:url value="/static/js/jquery.rss.js" var="jqueryRSS" />
	<script src="${jqueryRSS}"></script>

	<spring:url value="/static/js/bootstrap.min.js" var="bootstrapJS" />
	<script src="${bootstrapJS}"></script>
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		var data = eval('${users}');
		var table = $('#users').DataTable({
			"processing" : true,
			"scrollY" : true,
			"scrollX" : true,
			"aaData" : data,
			"aoColumns" : [ {
				"class" : "details-control",
				"orderable" : false,
				"data" : null,
				"defaultContent" : ""
			}, {
				"mData" : "firstName",
				"defaultContent" : "S/D"
			}, {
				"mData" : "lastName",
				"defaultContent" : "S/D"
			}, {
				"mData" : "email",
				"defaultContent" : "S/D"
			}, {
				"mData" : "ssoId",
				"defaultContent" : "S/D"
			} ]
		});
		table.columns.adjust().draw();
		// Array to track the ids of the details displayed rows
		var detailRows = [];

		$('#users tbody').on('click', 'tr td.details-control', function() {
			var tr = $(this).closest('tr');
			var row = table.row(tr);
			var idx = $.inArray(tr.attr('id'), detailRows);

			if (row.child.isShown()) {
				tr.removeClass('details');
				row.child.hide();

				// Remove from the 'open' array
				detailRows.splice(idx, 1);
			} else {
				tr.addClass('details');
				row.child(detalleEquipo(row.data())).show();

				// Add to the 'open' array
				if (idx === -1) {
					detailRows.push(tr.attr('id'));
				}
			}
		});

		// On each draw, loop over the `detailRows` array and show any child rows
		table.on('draw', function() {
			$.each(detailRows, function(i, id) {
				$('#' + id + ' td.details-control').trigger('click');
			});
		});

		// $('#panel-body').css( 'display', 'block' );
		// table.columns.adjust().draw();

	});

	function detalleEquipo(d) {
		return '<strong>Realizar una accion: </strong><br><br>'
		+ '<div class="container-fluid">'
		+ '<div class="row">'
		+ '<div class="col-xs-6 col-sm-2"><a href="<c:url value="/abm-usuarios-rdp/edit-user-{'+d.ssoId+'}" />"	class="btn btn-success custom-width">modificar</a></div>' //columna 1	
		+ '<div class="col-xs-6 col-sm-2"><c:choose><c:when test="${abm}"><a href="<c:url value="/abm-usuarios-rdp/delete-user-{'+d.ssoId+'}" />"	class="btn btn-danger custom-width">baja</a></c:when></c:choose></div>' //columna 2
		+ '</div></div></div>';
	}
	
	</script>
		

	
	<%@include file="footer.jsp"%>
</body>
</html>
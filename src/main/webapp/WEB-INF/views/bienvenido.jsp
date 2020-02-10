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
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target="#main-nav">
							<span class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#" title="Registro de Parque Informático">RDP</a>
					</div>
					<div class="collapse navbar-collapse" id="main-nav">
						<ul class="nav navbar-nav navbar-right">
							<c:choose>
								<c:when test="${gerente}">
									<li><a href="<c:url value='/abm-host/lista-de-equipos/' />">Listado de Equipos</a></li>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${abm}">
									<li><a href="<c:url value='/abm-usuarios-rdp/lista-de-usuarios' />">Administración de Usuarios</a></li>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${abm}">
									<li><a href="<c:url value='/abm-host/host-movimientos/' />">Ver	Movimientos</a></li>
								</c:when>
							</c:choose>
							<li><a href="<c:url value='/abm-host/alta-de-host/' />">Alta de Equipos</a></li>
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
			<h2>Bienvenido ${rol}</h2>
			<br> <br>
			
			<c:choose>
				<c:when test="${gerente}">
		<div class="panel-group">
			<div class="panel panel-primary">
				<div class="panel-heading"><b>Dashboard</b></div>

				<div class="panel-body">
					<div class="row">
						<div class="col-lg-10">
							<div class="panel panel-primary">
								<div class="panel-heading"><b>Equipos por Area</b></div>
								<div class="panel-body">
									<div class="img-responsive" id="equiposArea" style="width: 800px; height: 400px;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-10">
							<div class="panel panel-primary">	
								<div class="panel-heading"><b>Equipos Activos</b></div>
								<div class="panel-body">
									<div class="img-responsive" id="equiposActivos" style="width: 800px; height: 400px;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
				</div>					
				</c:when>
			</c:choose>
			
		  <c:choose>
				<c:when test="${!gerente}">
			
			<div class="panel-group">
				<div class="panel panel-primary">
					<div class="panel-heading ">
						<b>Listado de Equipos</b>
					</div>

					<div class="panel-body">

						<!-- <img src="https://chart.googleapis.com/chart?chs=150x150&amp;cht=qr&amp;chl=Hello%20world&amp;choe=UTF-8" alt="QR code">
 ${listaHost} 
-->
						<table class="table table-striped table-bordered nowrap cargando" cellspacing="0" width="100%" id="lstHost">
							<thead>
								<tr>
									<th></th>
									<th>EQUIPO</th>
									<th>MAC</th>
									<th>IP</th>
									<th>AREA</th>
									<th>CPU</th>
									<th>CPU MODELO</th>
									<th>CPU Mhz</th>
									<th>CPU FISICAS</th>
									<th>CPU NUCLEOS</th>
									<th>SISTEMA OPERATIVO</th>
									<th>SO ARQUITECTURA</th>
									<th>SO VERSION</th>
									<th>JAVA VERSION</th>
									<th>RAM</th>
									<th>DISCO</th>
									<th>Ultima Actualización</th>
								</tr>
							</thead>
						</table>



						<br>
						<div class="row">
							<div class="col-md-4">
								<a onclick="printPage()" class="btn btn-primary btn-l"> <span
									class="glyphicon glyphicon-print"></span> Imprimir Listado
								</a>
							</div>
							<div class="col-md-4">
								<a
									onclick="tablesToExcel(['lstHost'], ['Listado de equipos'], 'reporteEquipos.xls', 'Excel')"
									class="btn btn-primary btn-l"> <span
									class="glyphicon glyphicon-export"></span> Exportar a Excel
								</a>
							</div>
							<div class="col-md-4">
								<a href="https://rdp-gcba.herokuapp.com/static/rdp-agente/rdp-agente.rar"
									class="btn btn-primary btn-l"> <span
									class="glyphicon glyphicon-download"></span> Descargar
									RDP-Agente
								</a>
							</div>

							<div class="col-md-4"></div>
						</div>

					</div>
				</div>
			</div>
			
							</c:when>
			</c:choose>
		</div>



	</section>
	</main>


	<%@include file="footer.jsp"%>
	
	<spring:url value="/static/js/graficos.js" var="chart" />
	<script src="${chart}"></script>
	<spring:url value="/static/js/graficosTorta.js" var="chartTorta" />
	<script src="${chartTorta}"></script>

	<spring:url value="/static/js/jquery.rss.js" var="jqueryRSS" />
	<script src="${jqueryRSS}"></script>


	<spring:url value="/static/js/bootstrap.min.js" var="bootstrapJS" />
	<script src="${bootstrapJS}"></script>
	
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		var data = eval('${listaHost}');
		var table = $('#lstHost').DataTable({
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
				"mData" : "red_host",
				"defaultContent" : "S/D"
			}, {
				"mData" : "mac",
				"defaultContent" : "S/D"
			}, {
				"mData" : "ip",
				"defaultContent" : "S/D"
			}, {
				"mData" : "hostArea.type",
				"defaultContent" : "S/D"
			}, {
				"mData" : "cpu_vendedor",
				"defaultContent" : "S/D"
			}, {
				"mData" : "cpu_modelo",
				"defaultContent" : "S/D"
			}, {
				"mData" : "cpu_mhz",
				"defaultContent" : "S/D"
			}, {
				"mData" : "cpu_fisicas",
				"defaultContent" : "S/D"
			}, {
				"mData" : "cpu_nucleos",
				"defaultContent" : "S/D"
			}, {
				"mData" : "so_fabricante",
				"defaultContent" : "S/D"
			}, {
				"mData" : "so_arquitectura",
				"defaultContent" : "S/D"
			}, {
				"mData" : "so_version",
				"defaultContent" : "S/D"
			}, {
				"mData" : "java_version",
				"defaultContent" : "S/D"
			}, {
				"mData" : "ram"
			}, {
				"mData" : "hdd"
			}, {
				"mData" : "fechahora"
			} ]
		});
		table.columns.adjust().draw();
		// Array to track the ids of the details displayed rows
		var detailRows = [];

		$('#lstHost tbody').on('click', 'tr td.details-control', function() {
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
				row.child(detalleHost(row.data())).show();

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

	function detalleHost(d) {
		//Agrego abm host botones
		return '<strong>Realizar una accion: </strong><br><br>'
				+ '<div class="container-fluid">'
				+ '<div class="row">'
				+ '<div class="col-xs-6 col-sm-2"><a class="btn btn-primary btn-l" data-toggle="modal" data-target="#observaciones" > Agregar Observacion</a></div>' //columna 1				
				+ '<div class="col-xs-6 col-sm-2"><a href="<c:url value="/abm-host/movimiento-host-{'
				+ d.mac
				+ '}"/>" class="btn btn-primary btn-l" data-toggle="modal"  > Ver Historial</a></div>' //columna 2
				+ '<div class="col-xs-6 col-sm-2"><c:choose><c:when test="${abm}"><a href="<c:url value="/abm-host/edit-host-{'
				+ d.mac
				+ '}" />" class="btn btn-success custom-width">modificar</a></c:when></c:choose><c:choose><c:when test="${coordinador}"><a href="<c:url value="/abm-host/edit-host-{'
				+ d.mac
				+ '}" />" class="btn btn-success custom-width">modificar</a></c:when></c:choose></div>'//columna 3
				+ '<div class="col-xs-6 col-sm-2"><c:choose><c:when test="${abm}"><a href="<c:url value="/abm-host/delete-host-{'
				+ d.mac
				+ '}" />" class="btn btn-danger custom-width">eliminar</a></c:when></c:choose></div><br><br>' //columna 4
				//Observaciones
				+ '<div class="container"><br><!-- Modal --><div class="modal fade" id="observaciones" role="dialog"><div class="modal-dialog"><!-- Modal content-->'
				+ '<div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button><h4 class="modal-title">Agregar Observaciones</h4>'
				+ '</div><div class="modal-body"><main class="main-container no-padding-top" role="main"><section><form id="frmObservacion" action="<c:url value="/abm-host/observaciones-host-{'
				+ d.mac
				+ '}"/>" method="get" onsubmit="submit.disabled=true;  return true;">'
				+ '<input name="observact" style="display:none;" value="" type="text">'
				+ '<div class="container"><div class="form-group">Agregar observaciones del equipo :'
				+ d.red_host
				+ '<label for="obs"></label>'
				+ '<div class="row"><div class="col-xs-6"><textarea type="text" id="observac" class="form-control input-lg" name="observa" required></textarea></div>'
				+ '</div><br><div class="row"><div class="col-xs-6"><input type="submit" name="submit" class="btn btn-primary btn-lg" value="Agregar" ></div></div></div></div></form></section></main>'
				+ '</div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button></div></div>'
				+ '</div></div>' + '</div>';
	}
	
	</script>
</body>
</html>
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
						<a class="navbar-brand" href="#"
							title="Registro de Parque Informático">RDP</a>

					</div>
					<div class="collapse navbar-collapse" id="main-nav">
						<ul class="nav navbar-nav navbar-right">
							<c:choose>
								<c:when test="${abm}">
									<li><a
										href="<c:url value='/abm-usuarios-rdp/lista-de-usuarios' />">ABM-Usuarios</a>
									</li>
								</c:when>
							</c:choose>
							<li><a href="<c:url value='/bienvenido/' />">Volver</a></li>
							<li><a
								href="<c:url value='/editar/editar-perfil/' />"><span
									class="glyphicon glyphicon-user"></span> ${usuario.firstName}
									${usuario.lastName} </a></li>
							<li><a href="<c:url value='/index' />"><span
									class="glyphicon glyphicon-log-in"></span> Salir</a></li>
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
			<h2>Movimientos</h2>
			<br> <br>
			<div class="panel-group">
				<div class="panel panel-primary">
					<div class="panel-heading ">
						<b>Historial de Movimientos</b>
					</div>

					<div class="panel-body">

						<!-- <img src="https://chart.googleapis.com/chart?chs=150x150&amp;cht=qr&amp;chl=Hello%20world&amp;choe=UTF-8" alt="QR code">
 ${listaHost} 
-->				<table class="table table-striped table-bordered nowrap cargando"
							cellspacing="0" width="100%" id="lstHost">
							<thead>
								<tr>									
									<th>Fecha y Hora</th>									
									<th>MAC</th>
									<th>ID Usuario</th>
									<th>Operacion</th>
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
									onclick="tablesToExcel(['lstHost'], ['Movimientos del equipo'], 'reporteEquipo.xls', 'Excel')"
									class="btn btn-primary btn-l"> <span
									class="glyphicon glyphicon-export"></span> Exportar a Excel
								</a>
							</div>
						<div class="col-md-4">
							<a href="https://rdp-gcba.herokuapp.com/rdp-agente/Agente-3.0.exe" class="btn btn-primary btn-l"> <span
								class="glyphicon glyphicon-download"></span> Descargar RDP-Agente
							</a>
						</div>
						
						<div class="col-md-4"></div>
					</div>

				</div>
			</div>
		</div>
		</div>



	</section>
	</main>

	</section>
	</main>

	<%@include file="footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(
				 
				function() {
					var data = eval('${listaHost}');
					var table = $('#lstHost').DataTable({
						"processing" : true,
						"scrollY" : true, //300
						"scrollX" : true,
						"aaData" : data,
						"aoColumns" : [ 
							{
							"mData" : "fechahoramov",
							"defaultContent" : "S/D"
						}, {
							"mData" : "fkhost",
							"defaultContent" : "S/D"
						}, {
							"mData" : "user.ssoId",
							"defaultContent" : "S/D"
						}, {
							"mData" : "operacion",
							"defaultContent" : "S/D"
						}
						]
					});

				});
		
		

	</script>
	
			
<spring:url value="/static/js/jquery.rss.js" var="jqueryRSS" />
<script src="${jqueryRSS}"></script>

<spring:url value="/static/js/moment.js" var="momentJS" />
<script src="${momentJSs}"></script>


<spring:url value="/static/js/bootstrap.min.js" var="bootstrapJS" />
<script src="${bootstrapJS}"></script>
</body>
</html>
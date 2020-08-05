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
		<h2>Dashboard</h2>
		<br>
		<div class="panel-group">
			<div class="panel panel-primary">
				<div class="panel-heading"><b>Gráficos estadísticos</b></div>

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
				
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-10">
							<div class="panel panel-primary">	
								<div class="panel-heading"><b>Historial Egresos</b></div>
								<div class="panel-body">
									<div class="img-responsive" id="egresos" style="width: 800px; height: 400px;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
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
</body>
</html>
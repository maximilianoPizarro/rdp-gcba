<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="header.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Confirmation Page</title>
</head>
<body>
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
						<li><a
							href="<c:url value='/abm-usuarios-rdp/lista-de-usuarios' />">Volver</a></li>
						<li><a
							href="<c:url value='/editar/editar-perfil/' />"><span
								class="glyphicon glyphicon-user"></span> ${usuario.firstName}
								${usuario.lastName} </a></li>
						<li><a href="/index"><span
								class="glyphicon glyphicon-log-in"></span> Salir</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>


	<main class="main-container no-padding-top" role="main">
	<section>
		<div class="container" ng-controller="UserController as ctrl">
			<div class="panel-group">
				<div class="panel-body">
					<div class="alert alert-success lead">${success}</div>

					<br>
					<br>
					<!-- 		<span class="	"> Go to <a
						href="<c:url value='/list' />">Users List</a>
					</span>
			 -->
				</div>
			</div>
		</div>
	</section>
	</main>
		<spring:url value="/static/js/jquery.rss.js" var="jqueryRSS" />
	<script src="${jqueryRSS}"></script>
	<spring:url value="/static/js/bootstrap.min.js" var="bootstrapJS" />
	<script src="${bootstrapJS}"></script>
	<%@include file="footer.jsp"%>
</body>

</html>

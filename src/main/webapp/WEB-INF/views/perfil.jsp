<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="header.jsp"%>
<html>
<html>

<body>

	<!-- NAVEGACIï¿½N PRINCIPAL -->
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
						<li><a href="<c:url value='/bienvenido/' />">Volver</a></li>
						<li><a href="#"><span class="glyphicon glyphicon-user"></span>
								${user.firstName} ${user.lastName} </a></li>
						<li><a href="<c:url value='/index' />"><span
								class="glyphicon glyphicon-log-in"></span> Salir</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<!-- FIN DE NAVEGACIï¿½N PRINCIPAL -->

	<!-- CONTENIDO -->

	<!--

ACA VAN LOS CARTELES DE OPERACION EXITOSA Y ERROR

-->

	<main class="main-container no-padding-top" role="main"> <c:choose>
		<c:when test="${editado}">
			<div class="container">
				<div class="col-xs-12">
					<div class="alert-spot alert-spot-success">
						<div class="alert-link-text">
							<h4>${success}</h4>
						</div>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose> <c:choose>
		<c:when test="${errorEditar}">
			<div class="container">
				<div class="col-xs-12">
					<div class="alert-spot alert-spot-warning">
						<div class="alert-link-text">
							<h4>${warning}</h4>
						</div>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>

	<section>
		<form:form method="POST" modelAttribute="user">

			<div class="container">
				<h1 class="text-center">Perfil</h1>
				<br> <br>
				<div class="row">
					<div class="tab-content col-sm-6 col-sm-offset-3">

						<ul class="nav nav-pills nav-justified">
							<li role="perfil" class="active"><a class="" href="#usuario"
								aria-controls="usuario" role="tab" data-toggle="tab">Datos
									del Usuario</a></li>
							<li role="perfil"><a class="" href="#cuenta"
								aria-controls="cuenta" role="tab" data-toggle="tab">Datos de
									la Cuenta</a></li>
						</ul>

						<br> <br>

						<!-- Datos Usuario -->
						<div role="tabpanel" class="tab-pane active" id="usuario">

							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-heading text-center">
										<b>Datos del usuario</b>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<p>
												<strong>Apellido: </strong>${user.lastName}</p>
										</div>
										<div class="form-group">
											<p>
												<strong>Nombre: </strong>${user.firstName}</p>
										</div>
									</div>
								</div>
							</div>

							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-heading text-center">
										<b>Cambiar direcci&oacuten de email</b>
									</div>
									<div class="panel-body">
										<form:input type="hidden" path="id" id="id" />
										<form:input type="hidden" path="firstName" id="firstName" />
										<form:input type="hidden" path="lastName" id="lastName" />
										<form:input type="hidden" path="ssoId" id="ssoId" />
										
										<div class="form-group">
											<label for="email">Email:</label>
											<form:input type="text" path="email" id="email"
												class="form-control" autocomplete="off" required="true" />
											<br>
											<div class="has-error">
												<form:errors path="email"
													class="alert-spot alert-spot-danger" />
											</div>
										</div>
										<input type="submit" name="submitEmail"
											class="btn btn-primary pull-right" value="Cambiar">
									</div>
								</div>
							</div>

							<p>
							<center>
								Para cambiar sus datos personales <br> pongase en contacto
								con un administrador de RDP
							</center>
							</p>
						</div>
						<!-- Fin Datos Usuario -->

						<!-- Datos Cuenta -->
						<div role="tabpanel" class="tab-pane" id="cuenta">

							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-heading text-center">
										<b>Cuenta</b>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<p>
												<strong>Tipo de Usuario: </strong>${rol}</p>
										</div>
										<div class="form-group">
											<p>
												<strong>Nombre de Usuario: </strong>${user.ssoId}</p>
										</div>
									</div>
								</div>
							</div>

							<div class="col-lg-12">
								<div class="panel panel-default">
									<div class="panel-heading text-center">
										<b>Cambiar Contraseña</b>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<label for="cAntigua">Contraseña antigua:</label>
											<form:input type="password" path="password" id="password"
												class="form-control input-lg" autocomplete="off"
												required="true" />
											<br>
											<div class="has-error">
												<form:errors path="password"
													class="alert-spot alert-spot-danger" />
											</div>
										</div>
										<input type="submit" name="submitContra"
											class="btn btn-primary pull-right" value="Cambiar">
									</div>
								</div>
							</div>

						</div>
						<!-- Fin Datos Cuenta -->
					</div>
				</div>
			</div>
		</form:form>
	</section>
	</main>
	<!-- FIN CONTENIDO -->


	<%@include file="footer.jsp"%>

	<spring:url value="/static/bastrap3/jquery.min.js" var="jqueryJS" />
	<script src="${jqueryJS}"></script>
	<spring:url value="/static/bastrap3/bootstrap.min.js" var="boostrapJS" />
	<script src="${boostrapJS}"></script>


</body>
</html>
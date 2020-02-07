<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


</head>


<!-- NAVEGACIÓN PRINCIPAL -->
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

	</div>
</div>
</nav>
<!-- FIN DE NAVEGACIÓN PRINCIPAL -->

<body>

	<main class="main-container no-padding-top" role="main"> <section>
	<c:choose>
		<c:when test="${enviado}">
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
	</c:choose>
	
		<c:choose>
		<c:when test="${errorEmail}">
			<div class="container">
				<div class="col-xs-12">
					<div class="alert-spot alert-spot-danger">
						<div class="alert-link-text">
							<h4>${danger}</h4>
						</div>
					</div>
				</div>
			</div>
		</c:when>
	</c:choose>  
	
	<form:form action="/rdp/bienvenido/" modelAttribute="user"
		method="POST">

		<div class="container">
			<h2 class="h1 text-left">Iniciar Sesión</h2>
			<br>
			<div class="form-group">
				<label for="usuario">Usuario</label>
				<div class="row">
					<div class="col-xs-6">
						<form:input type="text" path="ssoId" id="ssoId"
							class="form-control input-lg" />
						<div class="has-error">
							<br>
							<form:errors path="ssoId" class="alert-spot alert-spot-danger" />
						</div>

					</div>
				</div>
				<br> <label for="usuario">Contraseña</label>
				<div class="row">
					<div class="col-xs-6">
						<form:input type="password" path="password" id="password"
							class="form-control input-lg" />
						<div class="has-error">
							<br>
							<form:errors path="password" class="alert-spot alert-spot-danger" />
						</div>

					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-xs-6">
						<input type="submit" value="Ingresar"
							class="btn btn-primary btn-lg" />
					</div>
				</div>

				<br> <a data-toggle="modal" data-target="#restaurar">
					Olvidé mi Contraseña</a>

			</div>
		</div>
	</form:form> ${message}
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="restaurar" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Restaurar Contrase&ntildea</h4>

					</div>

					<div class="modal-body">

						<main class="main-container no-padding-top" role="main"> <section>
						<form:form action="/rdp/rec-cuenta" modelAttribute="user"
							method="POST">

							<div class="container">
								<div class="form-group">
									<label for="email"> Escribe el email asociado a su
										cuenta para restaurar la contrase&ntildea </label>
									<div class="row">
										<div class="col-xs-6">
											<form:input type="email" path="email" id="email"
												class="form-control input-lg" />
											<div class="has-error">
												<br>
												<form:errors path="email"
													class="alert-spot alert-spot-danger" />
											</div>

										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-6">
											<input type="submit" class="btn btn-primary btn-lg"
												value="Recuperar contraseña">
										</div>
									</div>
								</div>
							</div>
						</form:form> </section> </main>

					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section> </main>

	<br>

	<%@include file="footer.jsp"%>
</body>

<spring:url value="/static/js/jquery.rss.js" var="jqueryRSS" />
<script src="${jqueryRSS}"></script>

<spring:url value="/static/js/jquery.min.js" var="jqueryMin" />
<script src="${jqueryMin}"></script>

<spring:url value="/static/js/bootstrap.min.js" var="bootstrapJS" />
<script src="${bootstrapJS}"></script>

</html>
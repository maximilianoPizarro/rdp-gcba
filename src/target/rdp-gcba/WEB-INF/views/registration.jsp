<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="header.jsp" %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
      <nav class="navbar navbar-default" role="navigation">
      <div class="container">
        <div class="row">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#main-nav">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            						<a class="navbar-brand" href="#"
							title="Registro de Parque Informático">RDP</a>
          </div>
          <div class="collapse navbar-collapse" id="main-nav">
            <ul class="nav navbar-nav navbar-right">
            
		      <li><a href="<c:url value='/abm-usuarios-rdp/lista-de-usuarios' />">Volver</a></li>
		      <li><a href="<c:url value='/editar/editar-perfil/' />"><span
									class="glyphicon glyphicon-user"></span> ${usuario.firstName}
									${usuario.lastName} </a></li>
      		  <li><a href="<c:url value='/index' />"><span class="glyphicon glyphicon-log-in"></span> Salir</a></li>
            </ul>
          </div>
        </div>
      </div>
    </nav>

    <main class="main-container no-padding-top" role="main">
    <section>

	<div class="container">
			<div class="panel-group">
    	    <div class="panel panel-primary">
			<!-- Default panel contents -->
			<div class="panel-heading">
		<span class="lead">Formulario de Usuario</span></div>
		
          <div class="panel-body">
		<form:form method="POST" modelAttribute="user" class="form-group col-md-12">
			<form:input type="hidden" path="id" id="id" />

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="firstName">Nombre </label>
					<div class="col-md-7">
						<form:input type="text" path="firstName" id="firstName"
							class="form-control input-lg" />
						<br>	
						<div class="has-error">
							<form:errors path="firstName" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="lastName">Apellido </label>
					<div class="col-md-7">
						<form:input type="text" path="lastName" id="lastName"
							class="form-control input-lg" />
						<br>
						<div class="has-error">
							<form:errors path="lastName" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="ssoId">SSO ID</label>
					<div class="col-md-7">
						<c:choose>
							<c:when test="${edit}">
								<form:input type="text"  path="ssoId" id="ssoId"
									class="form-control input-lg" disabled="true" />
							</c:when>
							<c:otherwise>
								<form:input type="text"  path="ssoId" id="ssoId"
									class="form-control input-lg" />
								<br>	
								<div class="has-error">
									<form:errors path="ssoId" class="alert-spot alert-spot-danger" />
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="password">Contraseña</label>
					<div class="col-md-7">
						<form:input type="password" path="password" id="password"
							class="form-control input-lg" />
						<br>	
						<div class="has-error">
							<form:errors path="password" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="email">Email</label>
					<div class="col-md-7">
						<form:input type="text" path="email" id="email"
							class="form-control input-lg" />
						<br>	
						<div class="has-error">
							<form:errors path="email" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="userProfiles">Rol</label>
					<div class="col-md-7">
						<form:select path="userProfiles" items="${roles}" multiple="true"
							itemValue="id" itemLabel="type" class="form-control input-lg" />
						<br>	
						<div class="has-error">
							<form:errors path="userProfiles" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
						  <div class="panel-group">
          <div class="panel-body">	
			<div class="row">
				<div class="form-actions floatRight">
					<c:choose>
						<c:when test="${edit}">
							<input type="submit" value="Actualizar"
								class="btn btn-success custom-width-lg" /> o	 <a class="btn btn-danger custom-width-lg"
								href="<c:url value='/abm-usuarios-rdp/lista-de-usuarios' />">Cancelar</a>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Registrar"
								class="btn btn-primary custom-width-lg" /> o <a class="btn btn-danger custom-width-lg"
								href="<c:url value='/abm-usuarios-rdp/lista-de-usuarios' />">Cancelar</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			</div></div>
		</form:form>
		
	</div></div></div></div>
	
	</section></main>
		<spring:url value="/static/js/jquery.rss.js" var="jqueryRSS" />
	<script src="${jqueryRSS}"></script>
	<spring:url value="/static/js/bootstrap.min.js" var="bootstrapJS" />
	<script src="${bootstrapJS}"></script>
<%@include file="footer.jsp" %>		
</body>
</html>
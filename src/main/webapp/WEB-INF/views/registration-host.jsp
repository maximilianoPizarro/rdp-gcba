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
            
		      <li><a href="<c:url value='/bienvenido/' />">Volver</a></li>
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
		<c:choose>
		<c:when test="${edit}">
		<span class="lead">Formulario de Modificación de Equipo</span>
		</c:when>
		<c:otherwise>
		<span class="lead">Formulario de Alta de Equipo</span>
		</c:otherwise>
		</c:choose>
		</div>
		
          <div class="panel-body">
		<form:form method="POST" modelAttribute="host" class="form-group col-md-12">
			<form:input type="hidden" path="idhost" id="idhost" />
			<form:input type="hidden" path="observacion" id="observacion" />
			<form:input type="hidden" path="loginultimomov" id="loginultimomov" />
			<form:input type="hidden" path="usuario" id="usuario"/>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="red_host">EQUIPO </label>
					<div class="col-md-7">
						<form:input type="text" path="red_host" id="red_host"
							class="form-control input-lg" placeholder="Nombre del equipo"/>
						<br>	
						<div class="has-error">
							<form:errors path="red_host" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>				
							
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="cpu_fisicas">CPU Fisicas </label>
					<div class="col-md-7">
						<form:input type="text" path="cpu_fisicas" id="cpu_fisicas"
							class="form-control input-lg" placeholder="4" />
						<br>	
						<div class="has-error">
							<form:errors path="cpu_fisicas" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="cpu_mhz">CPU Mhz </label>
					<div class="col-md-7">
						<form:input type="text" path="cpu_mhz" id="cpu_mhz"
							class="form-control input-lg" placeholder="2400"  />
						<br>
						<div class="has-error">
							<form:errors path="cpu_mhz" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="cpu_modelo">CPU Modelo </label>
					<div class="col-md-7">
						<form:input type="text" path="cpu_modelo" id="cpu_modelo"
							class="form-control input-lg" placeholder="Intel(R) Core(TM) i5-7400T "  />
						<br>
						<div class="has-error">
							<form:errors path="cpu_modelo" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="cpu_nucleos">CPU Nucleos </label>
					<div class="col-md-7">
						<form:input type="text" path="cpu_nucleos" id="cpu_nucleos"
							class="form-control input-lg"  placeholder="4" />
						<br>
						<div class="has-error">
							<form:errors path="cpu_nucleos" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="cpu_vendedor">CPU Vendedor</label>
					<div class="col-md-7">
						<form:input type="text" path="cpu_vendedor" id="cpu_vendedor"
							class="form-control input-lg"  placeholder="Intel"  />
						<br>
						<div class="has-error">
							<form:errors path="cpu_vendedor" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="java_version">Java Version</label>
					<div class="col-md-7">
						<form:input type="text" path="java_version" id="java_version"
							class="form-control input-lg" placeholder="1.8.0_181" />
						<br>
						<div class="has-error">
							<form:errors path="java_version" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="mac">MAC</label>
					<div class="col-md-7">
						<c:choose>
							<c:when test="${edit}">
								<form:input type="text"  path="mac" id="mac"
									class="form-control input-lg" disabled="true"  />
							</c:when>
							<c:otherwise>
								<form:input type="text"  path="mac" id="mac"
									class="form-control input-lg" placeholder="00-00-00-00-00-00" />
								<br>	
								<div class="has-error">
									<form:errors path="mac" class="alert-spot alert-spot-danger" />
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			
							
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="so_arquitectura">SO Arquitectura</label>
					<div class="col-md-7">
						<form:input type="text" path="so_arquitectura" id="so_arquitectura"
							class="form-control input-lg" placeholder="x32"/>
						<br>
						<div class="has-error">
							<form:errors path="so_arquitectura" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>				
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="so_fabricante">SO Fabricante</label>
					<div class="col-md-7">
						<form:input type="text" path="so_fabricante" id="so_fabricante"
							class="form-control input-lg" placeholder="Microsoft Windows" />
						<br>
						<div class="has-error">
							<form:errors path="so_fabricante" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>		
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="so_version">SO Version</label>
					<div class="col-md-7">
						<form:input type="text" path="so_version" id="so_version"
							class="form-control input-lg" placeholder="10"  />
						<br>
						<div class="has-error">
							<form:errors path="so_version" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="ram">Memoria RAM</label>
					<div class="col-md-7">
						<form:input type="number" path="ram" id="ram"
							class="form-control input-lg" />
						<br>
						<div class="has-error">
							<form:errors path="ram" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="hdd">Disco Rigido</label>
					<div class="col-md-7">
						<form:input type="number" path="hdd" id="hdd"
							class="form-control input-lg" />
						<br>
						<div class="has-error">
							<form:errors path="hdd" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
<!-- 			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="so_version">Usuarios</label>
					<div class="col-md-7">
						<form:input type="text" path="usuario" id="usuario"
							class="form-control input-lg" />
						<br>
						<div class="has-error">
							<form:errors path="usuario" class="alert-spot alert-spot-danger" />
						</div>
					</div>
				</div>
			</div>
 -->			<!-- ${areas} -->
			
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-3 control-lable" for="hostarea">Area</label>
					<div class="col-md-7">
						<form:select path="hostArea" items="${areas}" multiple="true"
							itemValue="id" itemLabel="type" class="form-control input-lg" />
						<br>	
						<div class="has-error">
							<form:errors path="hostArea" class="alert-spot alert-spot-danger" />
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
								href="<c:url value='/bienvenido/' />">Cancelar</a>
						</c:when>
						<c:otherwise>
							<input type="submit" value="Registrar"
								class="btn btn-primary custom-width-lg" /> o <a class="btn btn-danger custom-width-lg"
								href="<c:url value='/bienvenido/' />">Cancelar</a>
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
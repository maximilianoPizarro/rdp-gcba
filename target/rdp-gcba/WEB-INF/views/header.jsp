<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<!--[if lt IE 7]><html lang="es" class="lt-ie10 lt-ie9 lt-ie8 lt-ie7"><![endif]-->
<!--[if IE 7]><html lang="es" class="lt-ie10 lt-ie9 lt-ie8"><![endif]-->
<!--[if IE 8]><html lang="es" class="lt-ie10 lt-ie9"> <![endif]-->
<!--[if IE 9]><html lang="es" class="lt-ie10"> <![endif]-->
<!--[if gt IE 9]><!-->
<html lang="es" xmlns="http://www.w3.org/1999/xhtml">
<!--<![endif]-->
<head>
<!-- <meta charset="UTF-8 / ISO-8859-1"> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Sitio externo del Gobierno de la Ciudad de Buenos Aires.">
<meta name="author" content="Gobierno de la Ciudad de Buenos Aires">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<title>Gobierno de la Ciudad de Buenos Aires</title>


<link rel="apple-touch-icon-precomposed"
	href="<c:url value='/static/bastrap3/favicon-mobile.png' />">
<link rel="shortcut icon"
	href="<c:url value='/static/bastrap3/favicon.ico' />">
<link rel="stylesheet"
	href="<c:url value='/static/bastrap3/assset/buenosaires.css' />">
<link rel="stylesheet"
	href="<c:url value='/static/bastrap3/bootstrap.min.css' />">
<link rel="stylesheet"
	href="<c:url value='/static/bastrap3/bastrap.css' />">
<!-- <link rel="stylesheet" href="<c:url value='/static/css/app.css' />"> -->

<spring:url value="/static/js/script.js" var="scriptJS" />
<script src="${scriptJS}"></script>

<spring:url value="/static/js/jquery-1.12.1.min.js" var="jqueryJs" />
<script src="${jqueryJs}"></script>
<spring:url value="/static/js/jquery.dataTables.js" var="datatable" />
<script src="${datatable}"></script>
<!-- 
<spring:url value="/static/css/jquery.dataTables.css"
	var="jquerydataTables" />
<link href="${jquerydataTables}" rel="stylesheet" />
<spring:url value="/static/css/jquery.dataTables.min.css"
	var="jquerydataTablesMin" />
<link href="${jquerydataTablesMin}" rel="stylesheet" />
 -->


<!-- jQuery library -->


<!-- jQuery autocomplete -->
<!-- ESTILOS EXTRA -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<header class="navbar navbar-primary navbar-top">
	<div class="container">
		<div class="row ">
			<div class="col-md-6 col-sm-6">
				<a class="navbar-brand bac-header" href="#"></a>
			</div>
			<div class="col-md-6 col-sm-6 text-right oculto">
				<h5 class="sub-brand">
					<img src="<c:url value='/static/bastrap3/bac-header-2.png' />" />
				</h5>
				<!--<h5 class="sub-brand">Vamos Buenos Aires</h5>-->
			</div>
		</div>
	</div>
</header>
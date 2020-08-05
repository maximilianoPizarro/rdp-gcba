$(document).ready(function() {
	var data = eval('${listaHost}');
	var table = $('#lstHost').DataTable({
		"processing" : true,
		"scrollY" : 300,
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
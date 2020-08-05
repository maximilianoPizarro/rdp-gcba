/* Fecha y Hora */
/* COMIENZA EL SCRIPT DEL RELOJ */
function actualizaReloj() {
	/* CAPTURAMOS LA HORA, LOS MINUTOS Y LOS SEGUNDOS */
	marcacion = new Date()
	/* CAPTURAMOS LA HORA */
	Hora = marcacion.getHours()
	/* CAPTURAMOS LOS MINUTOS */
	Minutos = marcacion.getMinutes()
	/* CAPTURAMOS LOS SEGUNDOS */
	Segundos = marcacion.getSeconds()
	/* SI LA HORA, LOS MINUTOS O LOS SEGUNDOS 
	SIN MENORES O IGUAL A 9, LE AÑADIMOS UN 0 */
	if (Hora <= 9)
		Hora = "0" + Hora
	if (Minutos <= 9)
		Minutos = "0" + Minutos
	if (Segundos <= 9)
		Segundos = "0" + Segundos
		/* TERMINA EL SCRIPT DEL RELOJ */
		/* COMIENZA EL SCRIPT DE LA FECHA */
	var Dia = new Array("Domingo", "Lunes", "Martes", "Miercoles", "Jueves",
			"Viernes", "Sábado", "Domingo");
	var Mes = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
			"Julio", "Agosto", "Septiembre", "Octubre", "Noviembre",
			"Diciembre");
	var Hoy = new Date();
	var Anio = Hoy.getFullYear();
	var Fecha = "Ciudad Autonoma de Buenos Aires, " + Dia[Hoy.getDay()] + ", "
			+ Hoy.getDate() + " de " + Mes[Hoy.getMonth()] + " de " + Anio
			+ ". Hora local: ";
	/* TERMINA EL SCRIPT DE LA FECHA */
	/* CREAMOS 4 VARIABLES PARA DARLE FORMATO A NUESTRO SCRIPT */
	var Inicio, Script, Final, Total
	/* EN INICIO LE INDICAMOS UN COLOR DE FUENTE Y UN TAMAÑO */
	Inicio = " "
	/* EN RELOJ LE INDICAMOS LA HORA, LOS MINUTOS Y LOS SEGUNDOS */
	Script = Fecha + Hora + ":" + Minutos + ":" + Segundos
	/* EN FINAL CERRAMOS EL TAG DE LA FUENTE */
	Final = " "
	/* EN TOTAL FINALIZAMOS EL RELOJ UNIENDO LAS VARIABLES */
	Total = Inicio + Script + Final
	/* CAPTURAMOS UNA CELDA PARA MOSTRAR EL RELOJ */
	document.getElementById('Fecha_Reloj').innerHTML = Total
	/* INDICAMOS QUE NOS REFRESQUE EL RELOJ CADA 1 SEGUNDO */
	setTimeout("actualizaReloj()", 1000)
}

/*imprimir pantalla*/
function printPage() {
	window.print();
}

/*exportar tabla a excel sin la columna 1*/
var tablesToExcel = (function() {
	var uri = 'data:application/vnd.ms-excel;base64,', tmplWorkbookXML = '<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?><Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
			+ '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"><Author>Axel Richter</Author><Created>{created}</Created></DocumentProperties>'
			+ '<Styles>'
			+ '<Style ss:ID="Currency"><NumberFormat ss:Format="Currency"></NumberFormat></Style>'
			+ '<Style ss:ID="Date"><NumberFormat ss:Format="Medium Date"></NumberFormat></Style>'
			+ '</Styles>' + '{worksheets}</Workbook>', tmplWorksheetXML = '<Worksheet ss:Name="{nameWS}"><Table>{rows}</Table></Worksheet>', tmplCellXML = '<Cell{attributeStyleID}{attributeFormula}><Data ss:Type="{nameType}">{data}</Data></Cell>', base64 = function(
			s) {
		return window.btoa(unescape(encodeURIComponent(s)))
	}, format = function(s, c) {
		return s.replace(/{(\w+)}/g, function(m, p) {
			return c[p];
		})
	}
	return function(tables, wsnames, wbname, appname) {
		var ctx = "";
		var workbookXML = "";
		var worksheetsXML = "";
		var rowsXML = "";

		for (var i = 0; i < tables.length; i++) {
			if (!tables[i].nodeType)
				tables[i] = document.getElementById(tables[i]);
			for (var j = 0; j < tables[i].rows.length; j++) {
				rowsXML += '<Row>'
				for (var k = 1; k < tables[i].rows[j].cells.length; k++) {
					var dataType = tables[i].rows[j].cells[k]
							.getAttribute("data-type");
					var dataStyle = tables[i].rows[j].cells[k]
							.getAttribute("data-style");
					var dataValue = tables[i].rows[j].cells[k]
							.getAttribute("data-value");
					dataValue = (dataValue) ? dataValue
							: tables[i].rows[j].cells[k].innerHTML;
					var dataFormula = tables[i].rows[j].cells[k]
							.getAttribute("data-formula");
					dataFormula = (dataFormula) ? dataFormula
							: (appname == 'Calc' && dataType == 'DateTime') ? dataValue
									: null;
					ctx = {
						attributeStyleID : (dataStyle == 'Currency' || dataStyle == 'Date') ? ' ss:StyleID="'
								+ dataStyle + '"'
								: '',
						nameType : (dataType == 'Number'
								|| dataType == 'DateTime'
								|| dataType == 'Boolean' || dataType == 'Error') ? dataType
								: 'String',
						data : (dataFormula) ? '' : dataValue,
						attributeFormula : (dataFormula) ? ' ss:Formula="'
								+ dataFormula + '"' : ''
					};
					rowsXML += format(tmplCellXML, ctx);
				}
				rowsXML += '</Row>'
			}
			ctx = {
				rows : rowsXML,
				nameWS : wsnames[i] || 'Sheet' + i
			};
			worksheetsXML += format(tmplWorksheetXML, ctx);
			rowsXML = "";
		}

		ctx = {
			created : (new Date()).getTime(),
			worksheets : worksheetsXML
		};
		workbookXML = format(tmplWorkbookXML, ctx);

		console.log(workbookXML);

		var ff = new FormatoFecha();
		var Fecha = ff.toString();

		var link = document.createElement("A");
		link.href = uri + base64(workbookXML);
		link.download = Fecha + '-' + wbname || 'Workbook.xls';
		link.target = '_blank';
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
	}
})();

/*exportar tabla a excel con la columna 1*/
var tablesToExcel2 = (function() {
	var uri = 'data:application/vnd.ms-excel;base64,', tmplWorkbookXML = '<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?><Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
			+ '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"><Author>Axel Richter</Author><Created>{created}</Created></DocumentProperties>'
			+ '<Styles>'
			+ '<Style ss:ID="Currency"><NumberFormat ss:Format="Currency"></NumberFormat></Style>'
			+ '<Style ss:ID="Date"><NumberFormat ss:Format="Medium Date"></NumberFormat></Style>'
			+ '</Styles>' + '{worksheets}</Workbook>', tmplWorksheetXML = '<Worksheet ss:Name="{nameWS}"><Table>{rows}</Table></Worksheet>', tmplCellXML = '<Cell{attributeStyleID}{attributeFormula}><Data ss:Type="{nameType}">{data}</Data></Cell>', base64 = function(
			s) {
		return window.btoa(unescape(encodeURIComponent(s)))
	}, format = function(s, c) {
		return s.replace(/{(\w+)}/g, function(m, p) {
			return c[p];
		})
	}
	return function(tables, wsnames, wbname, appname) {
		var ctx = "";
		var workbookXML = "";
		var worksheetsXML = "";
		var rowsXML = "";

		for (var i = 0; i < tables.length; i++) {
			if (!tables[i].nodeType)
				tables[i] = document.getElementById(tables[i]);
			for (var j = 0; j < tables[i].rows.length; j++) {
				rowsXML += '<Row>'
				for (var k = 0; k < tables[i].rows[j].cells.length; k++) {
					var dataType = tables[i].rows[j].cells[k]
							.getAttribute("data-type");
					var dataStyle = tables[i].rows[j].cells[k]
							.getAttribute("data-style");
					var dataValue = tables[i].rows[j].cells[k]
							.getAttribute("data-value");
					dataValue = (dataValue) ? dataValue
							: tables[i].rows[j].cells[k].innerHTML;
					var dataFormula = tables[i].rows[j].cells[k]
							.getAttribute("data-formula");
					dataFormula = (dataFormula) ? dataFormula
							: (appname == 'Calc' && dataType == 'DateTime') ? dataValue
									: null;
					ctx = {
						attributeStyleID : (dataStyle == 'Currency' || dataStyle == 'Date') ? ' ss:StyleID="'
								+ dataStyle + '"'
								: '',
						nameType : (dataType == 'Number'
								|| dataType == 'DateTime'
								|| dataType == 'Boolean' || dataType == 'Error') ? dataType
								: 'String',
						data : (dataFormula) ? '' : dataValue,
						attributeFormula : (dataFormula) ? ' ss:Formula="'
								+ dataFormula + '"' : ''
					};
					rowsXML += format(tmplCellXML, ctx);
				}
				rowsXML += '</Row>'
			}
			ctx = {
				rows : rowsXML,
				nameWS : wsnames[i] || 'Sheet' + i
			};
			worksheetsXML += format(tmplWorksheetXML, ctx);
			rowsXML = "";
		}

		ctx = {
			created : (new Date()).getTime(),
			worksheets : worksheetsXML
		};
		workbookXML = format(tmplWorkbookXML, ctx);

		console.log(workbookXML);

		var ff = new FormatoFecha();
		var Fecha = ff.toString();

		var link = document.createElement("A");
		link.href = uri + base64(workbookXML);
		link.download = Fecha + '-' + wbname || 'Workbook.xls';
		link.target = '_blank';
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
	}
})();

/*mensajes confirma*/
function mensajeConfirma() {
	var txt;
	if (confirm("Presione aceptar para confirmar el egreso") == true) {
		txt = "You pressed OK!";
	} else {
		txt = "You pressed Cancel!";
	}
	document.getElementById("demo").innerHTML = txt;
}

function mensajeConfirmaI() {
	var txt;
	if (confirm("Presione aceptar para confirmar el ingreso") == true) {
		txt = "You pressed OK!";
	} else {
		txt = "You pressed Cancel!";
	}
	document.getElementById("demo").innerHTML = txt;
}
/*mostrar ocultar*/
$(document).ready(function() {
	$("#hide").click(function() {
		$("#div1").hide();
	});
	$("#show").click(function() {
		$("#div1").show();
	});
});

function FormatoFecha() {

	this.toString = function() {
		var f = new Date();
		var dia = f.getDate();
		var mes = f.getMonth() + 1;
		var anio = f.getFullYear();
		var hh = f.getHours();
		var mm = f.getMinutes();
		var ss = f.getSeconds();
		if (dia <= 9)
			dia = "0" + dia
		if (mes <= 9)
			mes = "0" + mes
		if (hh <= 9)
			hh = "0" + hh
		if (mm <= 9)
			mm = "0" + mm
		if (ss <= 9)
			ss = "0" + ss

		return dia + '-' + mes + '-' + anio + '-' + hh + '.' + mm;
	}
}

/* foreach */
function fillSelect(data) {
	//alert(data);
	$.each(data, function(i, item) {
		item.url;

	});
}

(function(i, s, o, g, r, a, m) {
	i['GoogleAnalyticsObject'] = r;
	i[r] = i[r] || function() {
		(i[r].q = i[r].q || []).push(arguments)
	}, i[r].l = 1 * new Date();
	a = s.createElement(o), m = s.getElementsByTagName(o)[0];
	a.async = 1;
	a.src = g;
	m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

ga('create', 'UA-17784640-34', 'auto');
ga('send', 'pageview');

/**
 *
 *  Base64 encode / decode
 *
 **/

function Base64() {

	// private property
	this._keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

	// public method for encoding
	this.encode = function(input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;

		input = this._utf8_encode(input);

		while (i < input.length) {

			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);

			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;

			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}

			output = output + this._keyStr.charAt(enc1)
					+ this._keyStr.charAt(enc2) + this._keyStr.charAt(enc3)
					+ this._keyStr.charAt(enc4);

		}

		return output;
	};

	// public method for decoding
	this.decode = function(input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;

		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

		while (i < input.length) {

			enc1 = this._keyStr.indexOf(input.charAt(i++));
			enc2 = this._keyStr.indexOf(input.charAt(i++));
			enc3 = this._keyStr.indexOf(input.charAt(i++));
			enc4 = this._keyStr.indexOf(input.charAt(i++));

			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;

			output = output + String.fromCharCode(chr1);

			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}

		}

		output = this._utf8_decode(output);

		return output;

	};

	// private method for UTF-8 encoding
	this._utf8_encode = function(string) {
		string = string.replace(/\r\n/g, "\n");
		var utftext = "";

		for (var n = 0; n < string.length; n++) {

			var c = string.charCodeAt(n);

			if (c < 128) {
				utftext += String.fromCharCode(c);
			} else if ((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			} else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}

		}

		return utftext;
	};

	// private method for UTF-8 decoding
	this._utf8_decode = function(utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;

		while (i < utftext.length) {

			c = utftext.charCodeAt(i);

			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			} else if ((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i + 1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			} else {
				c2 = utftext.charCodeAt(i + 1);
				c3 = utftext.charCodeAt(i + 2);
				string += String.fromCharCode(((c & 15) << 12)
						| ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}

		}

		return string;
	};

}

/*exportar tabla a excel
 var tableToExcel = (function() {
 var deco = new Base64();
 var uri = 'data:application/vnd.ms-excel;base64,'
 , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
 ,base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
 , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
 return function(table, name) {
 if (!table.nodeType) table = document.getElementById(table)
 var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
 window.location.href = uri + deco.encode(format(template, ctx))
 window.location.download="BackUpIngreso"
 }
 })()*/
//Setup
this.$('.js-loading-bar').modal({
	backdrop : 'static',
	show : false
});

$('#cargando').ready(function() {
	var $modal = $('.js-loading-bar'), $bar = $modal.find('.progress-bar');

	$modal.modal('show');
	$bar.addClass('animate');

	setTimeout(function() {
		$bar.removeClass('animate');
		$modal.modal('hide');
	}, 1500);
});



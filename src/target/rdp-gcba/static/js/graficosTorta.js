
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart); 


function drawChart() {

//por area 
		var jsonData = $.ajax({
	        url: "../service/por_area/",
	        dataType: "json",
	        async: false
	        }).responseText;
	
        var data = new google.visualization.DataTable(jsonData);

        var options = {
                title: '',
                is3D: true,
              };

        var chart = new google.visualization.PieChart(document.getElementById('equiposArea'));

        chart.draw(data,options);	
        
        
//activos
        var jsonData2 = $.ajax({
	        url: "../service/activos_hoy/",
	        dataType: "json",
	        async: false
	        }).responseText;
        
        var data2 = new google.visualization.DataTable(jsonData2);

        var options2 = {
                title: '',
                is3D: true,
              };
        
        var chart2 = new google.visualization.ColumnChart(document.getElementById('equiposActivos'));

        chart2.draw(data2,options2);	 


}
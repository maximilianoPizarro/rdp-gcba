package com.rdp.springmvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.rdp.springmvc.dao.GraficoTortaService;

@Controller
@RequestMapping("/service")
public class DashboardController {
	
	@Autowired
	GraficoTortaService graficoService;

	@RequestMapping(value = "/por_area/", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<String> tortaPorArea(ModelMap model,WebRequest request) {
		JsonObject json = new JsonObject();
		JsonObject parteUno=new JsonObject();
		JsonObject parteDos=new JsonObject();
		JsonArray jsonArray=new JsonArray();
		JsonParser parser = new JsonParser();

		parteUno.addProperty("id", "");
		parteUno.addProperty("label", "Topping");
		parteUno.addProperty("pattern", "");
		parteUno.addProperty("type", "string");
		parteDos.addProperty("id", "");
		parteDos.addProperty("label", "Slices");
		parteDos.addProperty("pattern", "");
		parteDos.addProperty("type", "number");		
		jsonArray.add(parteUno);
		jsonArray.add(parteDos);		
		json.add("cols", jsonArray);
		JsonElement jsonTree = parser.parse(graficoService.pcPorArea());
		
		json.add("rows",jsonTree);		
		
		//System.out.println(json);
		
		return new ResponseEntity<>(json.toString(), HttpStatus.FOUND);
	}
	
	@RequestMapping(value = "/activos_hoy/", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<String> tortaActivosHoy(ModelMap model,WebRequest request) {
		JsonObject json = new JsonObject();
		JsonObject parteUno=new JsonObject();
		JsonObject parteDos=new JsonObject();
		JsonArray jsonArray=new JsonArray();
		JsonParser parser = new JsonParser();

		parteUno.addProperty("id", "");
		parteUno.addProperty("label", "Topping");
		parteUno.addProperty("pattern", "");
		parteUno.addProperty("type", "string");
		parteDos.addProperty("id", "");
		parteDos.addProperty("label", "Slices");
		parteDos.addProperty("pattern", "");
		parteDos.addProperty("type", "number");		
		jsonArray.add(parteUno);
		jsonArray.add(parteDos);		
		json.add("cols", jsonArray);
		JsonElement jsonTree = parser.parse(graficoService.activosHoy());
		
		json.add("rows",jsonTree);		
		
		//System.out.println(json);
		
		return new ResponseEntity<>(json.toString(), HttpStatus.FOUND);
	}

	
	
}

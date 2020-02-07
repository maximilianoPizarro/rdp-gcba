package com.rdp.springmvc.service;


import java.io.IOException;
import java.util.GregorianCalendar;

import com.rdp.springmvc.funciones.Funciones;


public class HelloJob {
	
	
	public void execute() {
		
		System.out.println("Tarea cron");
		String escritorio = "\"D:\\back_up_rdp\\"+Funciones.traerFechaConGuiones(new GregorianCalendar())+"-backup_infraesctructura.backup\"";
		String user="postgres";
		String pass="root";
		String dbname="infraesctructura";
		
		String pg_dump="pg_dump --dbname=postgresql://"+user+":"+pass+"@127.0.0.1:5432/"+dbname+" -F c -b -v -f "+escritorio;
		//pg_dump --dbname=postgresql://postgres:root@127.0.0.1:5432/infraesctructura -F c -b -v -f "C:\Users\Max\Desktop\backup_infraesctructura.backup"
	
		try {
			Process start = Runtime.getRuntime().exec(pg_dump);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
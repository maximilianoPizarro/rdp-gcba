package com.rdp.springmvc.model;

import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name="host_update")
public class HostUpdate implements Serializable{
	
	private static final long serialVersionUID = 1L;
	@Id 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	@Column(name="fechahora", nullable=false)
	private Calendar fechahoramov;
	@Column(name="fkhost", nullable=false)
	private Integer fkhost;
	@Column(name="ip",nullable=false)
	private String ip;
	
	public HostUpdate(){}
	
	

	public HostUpdate(Calendar fechahoramov, Integer fkhost,String ip) {
		this.fechahoramov = fechahoramov;
		this.fkhost = fkhost;
		this.ip=ip;
	}



	public Integer getId() {
		return id;
	}

	protected void setId(Integer id) {
		this.id = id;
	}

	public Calendar getFechahoramov() {
		return fechahoramov;
	}

	public void setFechahoramov(Calendar fechahoramov) {
		this.fechahoramov = fechahoramov;
	}

	public Integer getFkhost() {
		return fkhost;
	}

	public void setFkhost(Integer fkhost) {
		this.fkhost = fkhost;
	}
	
	

	public String getIp() {
		return ip;
	}



	public void setIp(String ip) {
		this.ip = ip;
	}



	@Override
	public String toString() {
		return "HostUpdate [id=" + id + ", fechahoramov=" + Funciones.traerFechaCorta((GregorianCalendar)fechahoramov) + ", fkhost=" + fkhost + "]";
	}


	
	

}

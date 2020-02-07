package com.rdp.springmvc.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "traer_host_dos_semanas")
public class HostViewTwoWeek implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idhost;

	@NotEmpty
	@Column(name = "cpu_vendedor", nullable = false)
	private String cpu_vendedor;
	@NotEmpty
	@Column(name = "cpu_modelo", nullable = false)
	private String cpu_modelo;
	@NotEmpty
	@Column(name = "cpu_mhz", nullable = false)
	private String cpu_mhz;
	@NotEmpty
	@Column(name = "cpu_fisicas", nullable = false)
	private String cpu_fisicas;
	@NotEmpty
	@Column(name = "cpu_nucleos", nullable = false)
	private String cpu_nucleos;
	@NotEmpty
	@Column(name = "mac", nullable = false, unique = true)
	private String mac;
	@NotEmpty
	@Column(name = "red_host", nullable = false)
	private String red_host;
	@NotEmpty
	@Column(name = "so_fabricante", nullable = false)
	private String so_fabricante;
	@NotEmpty
	@Column(name = "so_arquitectura", nullable = false)
	private String so_arquitectura;
	@NotEmpty
	@Column(name = "so_version", nullable = false)
	private String so_version;
	@NotEmpty
	@Column(name = "java_version", nullable = false)
	private String java_version;
	
	@Column(name = "usuario", nullable = false)
	private String usuario;

	@Column(name = "ram", nullable = false)
	private long ram;

	@Column(name = "hdd", nullable = false)
	private long hdd;

	@Column(name = "observacion", nullable = false)
	private String observacion;

	@Column(name = "loginultimomov", nullable = false)
	private long loginultimomov;

	@OneToOne
	@JoinColumn(name = "hostarea_id", nullable = false)
	private HostArea hostArea;
	
	
	public static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	
	@Column(name = "fechahora")
	private Date fechahora;

	public HostViewTwoWeek() {
	};

	public int getIdhost() {
		return idhost;
	}

	public void setIdhost(int idhost) {
		this.idhost = idhost;
	}

	public String getCpu_vendedor() {
		return cpu_vendedor;
	}

	public void setCpu_vendedor(String cpu_vendedor) {
		this.cpu_vendedor = cpu_vendedor;
	}

	public String getCpu_modelo() {
		return cpu_modelo;
	}

	public void setCpu_modelo(String cpu_modelo) {
		this.cpu_modelo = cpu_modelo;
	}

	public String getCpu_mhz() {
		return cpu_mhz;
	}

	public void setCpu_mhz(String cpu_mhz) {
		this.cpu_mhz = cpu_mhz;
	}

	public String getCpu_fisicas() {
		return cpu_fisicas;
	}

	public void setCpu_fisicas(String cpu_fisicas) {
		this.cpu_fisicas = cpu_fisicas;
	}

	public String getCpu_nucleos() {
		return cpu_nucleos;
	}

	public void setCpu_nucleos(String cpu_nucleos) {
		this.cpu_nucleos = cpu_nucleos;
	}

	public String getMac() {
		return mac;
	}

	public void setMac(String mac) {
		this.mac = mac;
	}

	public String getRed_host() {
		return red_host;
	}

	public void setRed_host(String red_host) {
		this.red_host = red_host;
	}

	public String getSo_fabricante() {
		return so_fabricante;
	}

	public void setSo_fabricante(String so_fabricante) {
		this.so_fabricante = so_fabricante;
	}

	public String getSo_arquitectura() {
		return so_arquitectura;
	}

	public void setSo_arquitectura(String so_arquitectura) {
		this.so_arquitectura = so_arquitectura;
	}

	public String getSo_version() {
		return so_version;
	}

	public void setSo_version(String so_version) {
		this.so_version = so_version;
	}

	public String getJava_version() {
		return java_version;
	}

	public void setJava_version(String java_version) {
		this.java_version = java_version;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public HostArea getHostArea() {
		return hostArea;
	}

	public void setHostArea(HostArea hostArea) {
		this.hostArea = hostArea;
	}

	public long getRam() {
		return ram;
	}

	public void setRam(long ram) {
		this.ram = ram;
	}

	public long getHdd() {
		return hdd;
	}

	public void setHdd(long hdd) {
		this.hdd = hdd;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

	public long getLoginultimomov() {
		return loginultimomov;
	}

	public void setLoginultimomov(long loginultimomov) {
		this.loginultimomov = loginultimomov;
	}
	
	
	
	
	public String getFechahora() {
		return dateFormat.format(fechahora);
	}

	public void setFechahora(Date fechahora) {
		this.fechahora = fechahora;
	}

	@Override
	public String toString() {
		return "Host [idhost=" + idhost + ", cpu_vendedor=" + cpu_vendedor + ", cpu_modelo=" + cpu_modelo + ", cpu_mhz="
				+ cpu_mhz + ", cpu_fisicas=" + cpu_fisicas + ", cpu_nucleos=" + cpu_nucleos + ", mac=" + mac
				+ ", red_host=" + red_host + ", so_fabricante=" + so_fabricante + ", so_arquitectura=" + so_arquitectura
				+ ", so_version=" + so_version + ", java_version=" + java_version + ", usuario=" + usuario
				+ ", hostArea=" + hostArea + "]";
	}

}


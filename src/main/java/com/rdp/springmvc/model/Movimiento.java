package com.rdp.springmvc.model;

import java.io.Serializable;
import java.util.GregorianCalendar;

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
@Table(name = "movimiento")

public class Movimiento implements Serializable  {
	  
		
	private static final long serialVersionUID = 1L;
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

		@Column(name = "fechahoramov", nullable = false)
		private String fechahoramov;
		
		@Column(name = "operacion", nullable = false)
		private String operacion;
		
		@Column(name = "fkhost", nullable = false)
		private String fkhost;
/*		
		@Column(name = "fkuser", nullable = false)
		private long fkuser;
*/		
		@OneToOne
		@JoinColumn(name = "fkuser", nullable = false)
		private User user;	
		
		public Movimiento(){}

		
		
		public Integer getId() {
			return id;
		}



		public void setId(Integer id) {
			this.id = id;
		}



		public String getFechahoramov() {
			return fechahoramov;
		}

		public void setFechahoramov(String fechahoramov) {
			this.fechahoramov = fechahoramov;
		}

		public String getOperacion() {
			return operacion;
		}

		public void setOperacion(String operacion) {
			this.operacion = operacion;
		}

		public String getFkhost() {
			return fkhost;
		}

		public void setFkhost(String fkhost) {
			this.fkhost = fkhost;
		}



		public User getUser() {
			return user;
		}



		public void setUser(User user) {
			this.user = user;
		}


/*
		public long getFkuser() {
			return fkuser;
		}



		public void setFkuser(long fkuser) {
			this.fkuser = fkuser;
		}
*/

		
		
		
		

}

### Registro del Parque Informático *POC*

<p align="left">
<img src="https://raw.githubusercontent.com/wildfly/wildfly/main/logo/wildfly_logo.svg?style=for-the-badge&logo=wildfly&logoColor=white" alt="wildfly">
<img src="https://img.shields.io/badge/docker-0db7ed?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
<img src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="shell">
</p>

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/maximilianoPizarro/rdp-gcba)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)



Prototipado del Artefacto Web para dar soporte a la gestión de equipos infraestructura
de la Dirección General del Cuerpo de Agentes de Control del Tránsito y Seguridad Vial.

Ver más [aquí](https://github.com/maximilianoPizarro/rdp-gcba/blob/master/Registro%20del%20Parque%20Inform%C3%A1tico.pdf)

Técnologia Web:
- Java 8
- Spring Framework 4.3.0
- Hibernate 5.2.8
- JQuery-JavaScript-Bastrap
- PostgreSQL 9.0
- Apache Tomcat 7
&nbsp;

&nbsp;

&nbsp;
<p align="center">
  <img src="https://raw.githubusercontent.com/maximilianoPizarro/sugpa/master/screensMaqueta/1 - Iniciar sesión.jpg" width="800" title="hover text">
</p>  


## Environment

         PORT=8080
         JDBC_URL=jdbc:postgresql://localhost:5432/infraestructura
         JDBC_USERNAME=infraestructura        
         JDBC_PASSWORD=infraestructura    

## Instalación Docker Compose


1.  Instalar requerimientos:
    
         mvn clean install --batch-mode -DskipTests -P openshift

2.  Generar contenedor WildFly Centos7 con PosgresSQL 12:

         docker compose up   

2.  Acceder al sitio con Usuario/Clave:

         admin admin    

## Instalación Local

1.  Instalar requerimientos:
    
         mvn clean install --batch-mode -DskipTests -P heroku

2.  Levantar db PosgresSQL 12:

         docker compose -f postgresql.yml up  

3.  Correr Web App:

         chmod 777 start.sh    
         ./start.sh
         Desde el navegador http://localhost:8080/



## CI/CD en Heroku

        Agregar configuración en el archivo /Procfile
        https://github.com/heroku/webapp-runner
   

## Restore DB Manual Postgresql

        curl -l -o infraestructura.sql https://raw.githubusercontent.com/maximilianoPizarro/rdp-gcba/master/src/main/resources/db/migration/infraestructura.sql

        psql -f infraestructura.sql infraestructura
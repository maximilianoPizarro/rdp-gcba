## Instalación


1.  Instalar requerimientos:
    
         mvn clean install

2.  Crear variables de entorno:

        DATABASE_URL   
        PORT   

2.  Importar esquema base de datos:

        /pg-restore.sh    

3.  Correr Api: 
    
        /start.sh    

        Desde el navegador http://localhost:8080/


## CI/CD en Heroku

        Agregar configuración, si lo requieren en el archivo /Procfile
        

## Environment
        PORT   
        DATABASE_URL   

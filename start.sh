#!/usr/bin/env bash
PORT=8080
JDBC_URL=jdbc:postgresql://localhost:5432/infraestructura
JDBC_USERNAME=infraestructura        
JDBC_PASSWORD=infraestructura 
java $JAVA_OPTS -jar target/dependency/webapp-runner.jar --port $PORT target/*.war

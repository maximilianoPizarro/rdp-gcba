#!/usr/bin/env bash
cd src/
chmod +x src

java $JAVA_OPTS -jar target/dependency/webapp-runner.jar --port $PORT target/*.war
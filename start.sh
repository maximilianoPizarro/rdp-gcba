#!/usr/bin/env bash
cd source/
chmod +x source

java $JAVA_OPTS -jar target/dependency/webapp-runner.jar --port $PORT target/*.war
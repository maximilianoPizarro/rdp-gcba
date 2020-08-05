#!/usr/bin/env bash
cd src/
java $JAVA_OPTS -jar target/dependency/webapp-runner.jar --port $PORT target/*.war
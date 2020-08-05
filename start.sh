#!/usr/bin/env bash
java $JAVA_OPTS -jar target/dependency/webapp-runner.jar --port $PORT target/*.war

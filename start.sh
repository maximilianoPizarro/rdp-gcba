#!/usr/bin/env bash
cd imagen/
chmod +x imagen

java $JAVA_OPTS -jar webapp-runner.jar --port $PORT rdp-gcba.war
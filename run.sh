#!/bin/sh

DOCKER_IMAGE=login/app-demo
JAR_FILE=target/*.jar

[ ! -e $JAR_FILE ] && { echo "[APP] Building the project"; bash mvnw package; }

[ -e $JAR_FILE ] && { echo "[APP] Building the docker image"; docker build -t $DOCKER_IMAGE .; } ||
{ echo "[APP] Error: file 'JAR' not found"; exit 1; }

echo "[APP] Running '$DOCKER_IMAGE:latest'"
docker run -p 8080:8080 $DOCKER_IMAGE --name github_login

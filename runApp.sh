#!/bin/sh

DOCKER_IMAGE=demo/oath2
JAR_FILE=target/*.jar

read -p 'Enter your Github ClientId: ' CLIENT_ID
read -p 'Enter your Github ClientSecret: ' CLIENT_SECRET

echo "[APP] Building the project"
bash mvnw package

[ -e $JAR_FILE ] && 
{ 
    echo "[APP] Building the docker image";
    docker build -t $DOCKER_IMAGE --build-arg CLIENT_ID_VALUE=$CLIENT_ID --build-arg CLIENT_SECRET_VALUE=$CLIENT_SECRET .;

} || { echo "[APP] Error: file 'JAR' not found"; exit 1; }

echo "[APP] Running '$DOCKER_IMAGE:latest'"
docker run -p 8080:8080 $DOCKER_IMAGE --name github_login

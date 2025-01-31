#!/usr/bin/env bash

echo 'Building and installing the Maven project...'
set -x
mvn clean package
set +x

echo 'Extracting the project name...'
set -x
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name | sed 's/[^a-zA-Z0-9._-]//g')
set +x

echo 'Extracting the project version...'
set -x
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version | sed 's/[^a-zA-Z0-9._-]//g')
set +x

JAR_FILE="target/${NAME}-${VERSION}.jar"

echo "Checking if JAR file exists: $JAR_FILE"
if [ ! -f "$JAR_FILE" ]; then
    echo "Error: JAR file $JAR_FILE not found! Build may have failed."
    ls -lh target/
    exit 1
fi

echo 'Running the Java application...'
set -x
java -jar "$JAR_FILE"

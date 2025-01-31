#!/usr/bin/env bash

echo 'Building the Maven project...'
set -x
mvn clean package
set +x

echo 'Extracting the project name...'
set -x
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name)
set +x

echo 'Extracting the project version...'
set -x
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version)
set +x

JAR_FILE="target/${NAME}-${VERSION}.jar"

echo "Checking if $JAR_FILE exists..."
if [ ! -f "$JAR_FILE" ]; then
    echo "Error: JAR file $JAR_FILE not found. Build might have failed."
    exit 1
fi

echo 'Running the Java application...'
set -x
java -jar "$JAR_FILE"

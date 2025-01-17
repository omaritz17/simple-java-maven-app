#!/usr/bin/env bash

echo 'Installing your Maven-built Java application into the local repository...'
set -x
mvn -B jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'Extracting project name from pom.xml...'
set -x
NAME=$(mvn -B -q -DforceStdout help:evaluate -Dexpression=project.name | tr -d '\r' | tr -d '\033')
set +x

echo 'Extracting project version from pom.xml...'
set -x
VERSION=$(mvn -B -q -DforceStdout help:evaluate -Dexpression=project.version | tr -d '\r' | tr -d '\033')
set +x

echo "Project Name: $NAME"
echo "Project Version: $VERSION"

echo 'Checking if the JAR file exists...'
if [ ! -f "target/${NAME}-${VERSION}.jar" ]; then
    echo "Error: JAR file not found: target/${NAME}-${VERSION}.jar"
    exit 1
fi

echo 'Running the Java application...'
set -x
java -jar "target/${NAME}-${VERSION}.jar"

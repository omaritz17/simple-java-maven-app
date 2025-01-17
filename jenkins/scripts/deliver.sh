#!/usr/bin/env bash

echo 'Installing your Maven-built Java application into the local repository...'
set -x
mvn -B jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'Extracting project name from pom.xml...'
set -x
NAME=$(mvn -B help:evaluate -Dexpression=project.name | grep -v "^\[" | tail -1)
set +x

echo 'Extracting project version from pom.xml...'
set -x
VERSION=$(mvn -B help:evaluate -Dexpression=project.version | grep -v "^\[" | tail -1)
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

#!/bin/bash

echo "Building $BRANCH branch"

if [ "$BRANCH" = "develop" ]; then
  openssl version -a
  openssl aes-256-cbc -pass pass:$OPENSSL_PWD -in private-key.gpg.enc -out private-key.gpg -d && gpg --import --batch private-key.gpg && mvn -V -U -s settings.xml org.jacoco:jacoco-maven-plugin:prepare-agent clean deploy sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=$SONAR_ORGANIZATION -Dsonar.login=$SONAR
elif [ "$BRANCH" = "master" ]; then
  openssl version -a
  openssl aes-256-cbc -pass pass:$OPENSSL_PWD -in private-key.gpg.enc -out private-key.gpg -d && gpg --import --batch private-key.gpg && mvn -V -s settings.xml clean deploy
else
  mvn -V -s settings.xml -U clean package
fi
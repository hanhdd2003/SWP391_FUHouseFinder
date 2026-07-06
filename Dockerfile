FROM maven:3.9.9-eclipse-temurin-11 AS build

WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn -B -DskipTests package

FROM tomcat:10.1-jdk11-temurin

ENV CATALINA_OPTS="-Djava.awt.headless=true"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /build/target/HFManagementSystem-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/HFManagementSystem.war
COPY fuhf-sqlserver.sql /opt/tomcat/fuhf-sqlserver.sql

EXPOSE 8080

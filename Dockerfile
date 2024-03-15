FROM maven:3.8.7-openjdk-18-slim AS build

WORKDIR /opt/checkpoint1

COPY . .

RUN mvn clean package

FROM openjdk:18-slim

WORKDIR /opt/checkpoint1

COPY --from=build /opt/checkpoint1/target/app.jar .

ENV PROFILE=dev

EXPOSE 8080

ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILE}", "-jar", "app.jar"]

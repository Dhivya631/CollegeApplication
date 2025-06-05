FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY ./target/EngineeringCollegeApplication-1.0-SNAPSHOT.war college.war
EXPOSE 8080:8080
CMD ["java", "-war", "college.war"]

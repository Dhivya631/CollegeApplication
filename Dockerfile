FROM openjdk:17-jdk-slim
WORKDIR /app
COPY ./target/EngineeringCollegeApplication-1.0-SNAPSHOT.war college.war
EXPOSE 8080:8080
CMD ["java", "-jar", "college.war"]

# 💰 Engineering College Application

## 📌 Overview
The Engineering College Application is a comprehensive management system built using Spring Boot, designed to streamline core operations such as student admissions, course scheduling, and faculty management. It features a robust backend architecture with over 90% test coverage using JUnit and JaCoCo, and ensures high code quality through the integration of SonarLint, making it maintainable and production-ready.

---

## 🔧 Technology


| Technology         | Description                                       |
|--------------------|---------------------------------------------------|
| Java 18            | Core programming language                         |
| Spring Boot        | Backend framework for building REST APIs          |
| Spring Data JPA    | ORM tool to interact with PostgreSQL              |
| MySQL              | Relational database                               |
| JasperReports      | PDF report generation tool                        |
| JUnit 5            | Unit testing framework                            |
| JaCoCo             | Code coverage tool                                |
| Docker             | Containerization of app and database              |
| Docker Compose     | Multi-container orchestration                     |
| JSP, Bootstrap CSS | Frontend view layer                               |
| JavaScript         | UI interactions and validations                   |
| GitHub Actions     | CI/CD workflows for automated builds              |

---

## 🧩 Features

- 📚 Course and subject management for departments

- 🧑‍🎓 Student admission and profile creation

- 🧑‍🏫 Faculty assignment and class scheduling

- 🧪 Robust testing with JUnit 5 and Mockito

- 📈 Code coverage consistently above 90% using JaCoCo

- 🧹 Static code analysis using SonarLint to ensure clean code

---

## 🧬 ER Diagram

```text
+-------------+           +-------------+            +---------------+
|   Admin     |           | Department  |<--------+  |   Semester    |
+-------------+           +-------------+         |  +---------------+
| id (PK)     |           | id (PK)     |         |  | id (PK)       |
| email       |           | name        |         +--| name          |
| password    |           | description |            | department_id |
+-------------+           | hod         |            +---------------+
                          +-------------+                    ^
                                                            n|
                                                             |
+-------------+           +-------------+          +---------+---------+
|  Student    |           |  Course     |<------+  |  CourseSemester   |
+-------------+           +-------------+       |  +------------------+
| id (PK)     |           | id (PK)     |       |  | id (PK)          |
| name        |           | rno         |       +--| course_id (FK)   |
| username    |           | name        |          | semester_id (FK) |
| password    |           | description |          +------------------+
| email       |           | credit      |
| department  |-----------| dept_id (FK)|
| semester    |-----------+-------------+
+-------------+

                                ^
                                |
                                | n
+------------------+           |
|   Employee       |-----------+
+------------------+
| employee_id (PK) |
| name             |
| username         |
| password         |
| age              |
| email            |
| phone_no         |
| course           |
| designation      |
+------------------+

```
---

## 📂 Directory Structure
```text
EngineeringCollegeApplication/
├── src/
│   ├── main/
│   │   ├── java/org/example/
│   │   │   ├── controller/           # Spring MVC controllers
│   │   │   ├── config/               # Security & Web configurations
│   │   │   ├── model/                # Entity classes
│   │   │   ├── repository/           # Spring Data JPA repositories
│   │   │   ├── service/              # Business logic services
│   │   │   └── jspConfig/            # JSP view resolver config (if needed)
│   │   ├── resources/
│   │   │   └── application.properties # Spring Boot app properties
│   │   └── webapp/WEB-INF/jsp/       # JSP view templates
│   │       └── static/               # CSS, JS, images
│
│   └── test/
│       └── java/org/example/
│           ├── controller/           # Controller test cases
│           └── service/              # Service layer test cases
│
├── Dockerfile                        # Dockerfile for Spring Boot app
├── docker-compose.yml               # Compose file for multi-container setup
├── pom.xml                           # Maven configuration file
└── README.md                         # Project documentation

```
---

## 🚀 How to Run

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Dhivya631/CollegeApplication.git
   cd loan-management-system
    ```
2. **Build the WAR**
   ```bash
   mvn clean install
   ```
3. **Run with Docker Compose**
  ```bash
  docker-compose up --build
  ```
5. **Access**
   
     - App: http://localhost:8080
     - MySQL: localhost:3306

---

## 🧪 How to Test

- **Run unit tests:**
  ```bash
  mvn test
  ```
- **View code coverage report (after test):
  ```bash
  target/site/jacoco/index.html
  ```
  
---

## 🐳 Docker Setup

1. **Dockerfile**

   ```Dockerfile
    FROM amazoncorretto:22
    WORKDIR /app
    COPY ./target/EngineeringCollegeApplication-1.0-SNAPSHOT.war college.war
    EXPOSE 8080:8080
    CMD ["java", "-jar", "college.war"]
   ```

2. **docker-compose.yml**
   ```bash
     services:
      app:
        build:
          context: .
          dockerfile: Dockerfile
        container_name: engineeringcollegeapplication
        depends_on:
          - mysql
        environment:
          SPRING_DATASOURCE_URL: jdbc:mysql://mysql-db:3306/ecollege?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
          SPRING_DATASOURCE_USERNAME: ${{ secrets.DB_USERNAME }}
          SPRING_DATASOURCE_PASSWORD: ${{ secrets.DB_PASSWORD }}
        ports:
          - "8080:8080"
        networks:
          - spring-net
    
      mysql:
        image: mysql:8.0
        container_name: mysql-db
        environment:
          MYSQL_ROOT_PASSWORD: ${{ secrets.DB_PASSWORD }}
          MYSQL_DATABASE: ecollege
        ports:
          - "3307:3306"
        networks:
          - spring-net
        command: --default-authentication-plugin=mysql_native_password
    
    networks:
      spring-net:
        driver: bridge

   ```
3. **Build and Run Docker:**
   ```bash
   docker-compose up --build
   ```
---


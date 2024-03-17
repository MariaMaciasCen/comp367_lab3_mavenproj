# Use an appropriate base image with Java and Maven installed
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY pom.xml .
COPY src ./src

# Build the Maven project
RUN mvn clean package

# Use a lightweight base image to reduce image size
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged JAR file from the previous stage
COPY --from=build /app/target/comp367-0.0.1-SNAPSHOT.jar .

EXPOSE 8080  

# Specify the command to run your application
ENTRYPOINT ["java", "-jar", "comp367-0.0.1-SNAPSHOT.jar"]
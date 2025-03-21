# Stage 1: Build the .jar file
FROM eclipse-temurin:22-jdk AS build

# Set the working directory inside the container
WORKDIR /app

# Install Maven (since it's not available by default)
RUN apt-get update && apt-get install -y maven

# Copy your Maven POM file into the container (it holds all dependencies)
COPY pom.xml .

# Download all the dependencies specified in the pom.xml file
RUN mvn dependency:go-offline

# Copy your entire source code into the container
COPY src ./src

# Build the .jar file using Maven
RUN mvn clean package -DskipTests

# Stage 2: Run the Spring Boot app with the compiled .jar file
FROM eclipse-temurin:22-jdk

# Set the working directory inside the container for the second stage
WORKDIR /app

# Copy the .jar file generated in the build stage to this container
COPY --from=build /app/target/neh-0.0.1-SNAPSHOT.jar app.jar

# Expose the port used by Spring Boot
EXPOSE 9090

# Run the Spring Boot application with the specified profile (prod)
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=prod"]

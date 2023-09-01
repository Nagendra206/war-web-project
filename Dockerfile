# Use an official Maven image as a build environment
FROM maven:3.8.4-openjdk-11 AS build

# Copy the application source code to the container
COPY . /usr/src/app

# Set the working directory
WORKDIR /usr/src/app

# Build the application with Maven
RUN mvn clean install

# Use an official Tomcat image as the runtime environment
FROM tomcat:9.0-jdk11-openjdk-slim

# Copy the built WAR file from the Maven build container to the Tomcat container
COPY --from=build /usr/src/app/target/wwp-1.0.0.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port (8080)
EXPOSE 8080

# Start Tomcat when the container is run
CMD ["catalina.sh", "run"]

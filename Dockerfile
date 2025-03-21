# Utiliser OpenJDK 22 comme base (car tu utilises Java 22)
FROM eclipse-temurin:22-jdk

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier JAR compilé
COPY target/neh-0.0.1-SNAPSHOT.jar app.jar

# Exposer le port utilisé par Spring Boot (optionnel mais utile)
EXPOSE 9090

# Lancer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar" , "--spring.profiles.active=prod"]

# Используем многоэтапную сборку для минимизации размера итогового образа
FROM maven:3.9.9-amazoncorretto-21 AS build

# Копируем только необходимые файлы для сборки
COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src

# Сборка проекта
RUN mvn clean package -DskipTests

# Используем минимальный образ JDK для запуска
FROM eclipse-temurin:21-jdk-alpine

# Копируем JAR из стадии сборки
COPY --from=build target/*.jar app.jar

# Устанавливаем порт
EXPOSE 8080

# Запускаем приложение
ENTRYPOINT ["java", "-jar", "/app.jar"]

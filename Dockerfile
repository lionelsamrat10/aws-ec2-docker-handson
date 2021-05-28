FROM adoptopenjdk/openjdk11
WORKDIR /
ADD rest-api-rds.jar rest-api-rds.jar
EXPOSE 5000
CMD java -jar rest-api-rds.jar
FROM openjdk:11

ADD target/lib/* /deployments/lib/
ADD target/*-runner.jar /deployments/app.jar

# Configure the JAVA_OPTIONS, you can add -XshowSettings:vm to also display the heap size.
ENV JAVA_OPTIONS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager -XX:TieredStopAtLevel=1 -XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MinHeapFreeRatio=20 -XX:MaxHeapFreeRatio=40 -XX:+ExitOnOutOfMemoryError"

EXPOSE 8080
USER 1001

ENTRYPOINT exec java $JAVA_OPTIONS -cp . -jar /deployments/app.jar
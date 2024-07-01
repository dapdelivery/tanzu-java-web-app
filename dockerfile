ARG BUILDER_IMAGE=tap-sm-docker-dev-local.dmz.packages.broadcom.com/projects-registry/tanzu_adv_eng/maven
ARG RUNTIME_IMAGE=tap-sm-docker-dev-local.dmz.packages.broadcom.com/projects-registry/tanzu_adv_eng/java17-debian11


FROM $BUILDER_IMAGE AS build

        ADD . .
        RUN unset MAVEN_CONFIG && ./mvnw clean package -B -DskipTests


FROM $RUNTIME_IMAGE AS runtime

        COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar /demo.jar
        CMD [ "/demo.jar" ]

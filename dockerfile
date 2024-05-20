ARG BUILDER_IMAGE=projects.registry.vmware.com/tanzu_adv_eng/maven
ARG RUNTIME_IMAGE=projects.registry.vmware.com/tanzu_adv_eng/java17-debian11


FROM $BUILDER_IMAGE AS build

        ADD . .
        RUN unset MAVEN_CONFIG && ./mvnw clean package -B -DskipTests


FROM $RUNTIME_IMAGE AS runtime

        COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar /demo.jar
        CMD [ "/demo.jar" ]

package de.thaso.demo.examples.simplepayroll.worktime.service;

import io.smallrye.reactive.messaging.annotations.Blocking;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.concurrent.CompletionStage;

@ApplicationScoped
public class EmployeeConsumer {
    private static final Logger LOGGER = Logger.getLogger(EmployeeConsumer.class);

    @Blocking
    @Incoming("employee")
    public CompletionStage<Void> consumeEmployee(final KafkaRecord<String, Employee> kafkaRecord) {
        LOGGER.info("consumeEmployee: " + kafkaRecord.getPayload().toString());

        return kafkaRecord.ack();
    }
}

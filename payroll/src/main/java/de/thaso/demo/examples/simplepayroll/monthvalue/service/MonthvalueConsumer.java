package de.thaso.demo.examples.simplepayroll.monthvalue.service;

import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.concurrent.CompletionStage;

@ApplicationScoped
public class MonthvalueConsumer {
    private static final Logger LOGGER = Logger.getLogger(MonthvalueConsumer.class);

/*
    @Incoming("monthvalue")
    public CompletionStage<Void> consumeMonthvalue(final KafkaRecord<String, Monthvalue> kafkaRecord) {
        LOGGER.info("consumeMonthvalue: " + kafkaRecord.getPayload().toString());

        return kafkaRecord.ack();
    }
*/

    @Incoming("monthvalue")
    public void consumeMonthvalue(final Monthvalue kafkaRecord) {
        LOGGER.info("consumeMonthvalue: " + kafkaRecord.toString());
    }
}

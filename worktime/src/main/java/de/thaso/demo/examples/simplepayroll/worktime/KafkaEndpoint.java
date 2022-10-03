package de.thaso.demo.examples.simplepayroll.worktime;

import io.quarkus.runtime.ShutdownEvent;
import io.quarkus.runtime.StartupEvent;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.event.Observes;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Duration;
import java.util.Collections;

@Path("/average")
@ApplicationScoped
public class KafkaEndpoint {

    public static final String TOPIC = "values";

    @Inject
    KafkaConsumer<String, Integer> consumer;

    volatile boolean done = false;
    private BigDecimal average = BigDecimal.ZERO;
    private BigDecimal count = BigDecimal.ZERO;

    public void initialize(@Observes StartupEvent ev) {
        consumer.subscribe(Collections.singleton(TOPIC));
        new Thread(() -> {
            while (! done) {
                final ConsumerRecords<String, Integer> consumerRecords = consumer.poll(Duration.ofSeconds(1));

                consumerRecords.forEach(record -> {
                    final Integer value = record.value();
                    System.out.printf("\nPolled value : %d\n", value);
                    process(value);
                });
            }
            consumer.close();
        }).start();
    }

    private void process(final Integer value) {

        average = average.multiply(count)
                .add(BigDecimal.valueOf(value))
                .divide(count.add(BigDecimal.ONE), 15, RoundingMode.HALF_UP);
        count = count.add(BigDecimal.ONE);
        System.out.printf("Average is now %s after %s values.\n", average.toString(), count.toPlainString());
    }

    public void terminate(@Observes ShutdownEvent ev) {
        done = false;
    }

    @GET
    public String getLast() {
        System.out.printf("going to receive average: %s\n", average.toPlainString());
        return average.toPlainString();
    }

    @GET
    @Path("/reset")
    public String doReset() {
        System.out.println("reset average");
        average = BigDecimal.ZERO;
        count = BigDecimal.ZERO;
        return "done";
    }
}

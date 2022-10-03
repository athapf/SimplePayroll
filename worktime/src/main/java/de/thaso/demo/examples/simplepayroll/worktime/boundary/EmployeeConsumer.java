package de.thaso.demo.examples.simplepayroll.worktime.boundary;

import de.thaso.demo.examples.simplepayroll.worktime.entity.Employee;
import io.quarkus.runtime.ShutdownEvent;
import io.quarkus.runtime.StartupEvent;
import org.apache.kafka.clients.consumer.ConsumerRecords;

import javax.enterprise.event.Observes;
import javax.inject.Inject;
import java.time.Duration;
import java.util.Collections;

public class EmployeeConsumer {

    public static final String TOPIC = "values";

    @Inject
    org.apache.kafka.clients.consumer.KafkaConsumer<String, Employee> consumer;

    volatile boolean done = false;

    public void initialize(@Observes StartupEvent ev) {
        consumer.subscribe(Collections.singleton(TOPIC));
        new Thread(() -> {
            while (! done) {
                final ConsumerRecords<String, Employee> consumerRecords = consumer.poll(Duration.ofSeconds(1));

                consumerRecords.forEach(record -> {
                    final Employee employee = record.value();
                    System.out.printf("\nPolled value : \n");
                    process(employee);
                });
            }
            consumer.close();
        }).start();
    }

    private void process(final Employee employee) {
        System.out.printf("process employee.\n");
    }

    public void terminate(@Observes ShutdownEvent ev) {
        done = false;
    }
}

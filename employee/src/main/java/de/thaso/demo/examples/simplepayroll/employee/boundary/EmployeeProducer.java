package de.thaso.demo.examples.simplepayroll.employee.boundary;

import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;
import io.quarkus.runtime.ShutdownEvent;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

import javax.enterprise.event.Observes;
import javax.inject.Inject;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class EmployeeProducer {

    public static final String TOPIC = "values";

    @Inject
    KafkaProducer<String, Employee> producer;

    public void terminate(@Observes ShutdownEvent ev) {
        producer.close();
    }

    public Employee sendEmployee(final Employee employee)
            throws ExecutionException, InterruptedException, TimeoutException {
        producer.send(new ProducerRecord<>(TOPIC, "value", employee))
                .get(5, TimeUnit.SECONDS);
        return employee;
    }
}

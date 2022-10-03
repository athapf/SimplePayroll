package de.thaso.demo.examples.simplepayroll.employee.utils;

import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;
import io.smallrye.common.annotation.Identifier;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.common.serialization.StringSerializer;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;
import javax.inject.Inject;
import java.util.Map;

@ApplicationScoped
public class KafkaProviders {

    @Inject
    @Identifier("default-kafka-broker")
    Map<String, Object> config;

    @Produces
    KafkaProducer<String, Employee> getProducer() {
        return new KafkaProducer<>(config,
                new StringSerializer(),
                new EmployeeSerializer());
    }
}

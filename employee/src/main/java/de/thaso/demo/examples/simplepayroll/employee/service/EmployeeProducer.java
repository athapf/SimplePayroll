package de.thaso.demo.examples.simplepayroll.employee.service;

import io.smallrye.reactive.messaging.kafka.Record;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class EmployeeProducer {
    private static final Logger LOGGER = Logger.getLogger(EmployeeProducer.class);

    @Channel("employee")
    private Emitter<Record<String, Employee>> employeeEmitter;

    public Employee sendEmployee(final String key, final Employee payload) {
        employeeEmitter.send(Record.of(key, payload));
        return payload;
    }
}

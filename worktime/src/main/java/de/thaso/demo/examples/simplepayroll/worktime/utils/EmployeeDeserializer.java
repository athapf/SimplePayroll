package de.thaso.demo.examples.simplepayroll.worktime.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import de.thaso.demo.examples.simplepayroll.worktime.entity.Employee;
import org.apache.kafka.common.serialization.Deserializer;

import java.io.IOException;

public class EmployeeDeserializer implements Deserializer<Employee> {

    @Override
    public Employee deserialize(String topic, byte[] bytes) {
        final ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(bytes, Employee.class);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}

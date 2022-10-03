package de.thaso.demo.examples.simplepayroll.employee.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;
import org.apache.kafka.common.serialization.Serializer;

public class EmployeeSerializer implements Serializer<Employee> {
    @Override
    public byte[] serialize(String s, Employee employee) {
        final ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.writeValueAsBytes(employee);
        } catch (JsonProcessingException exception) {
            throw new RuntimeException(exception);
        }
    }
}

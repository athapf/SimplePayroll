package de.thaso.demo.examples.simplepayroll.employee.service;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class EmployeeServiceImpl implements EmployeeService {
    @Override
    public List<Employee> findAllEmployee() {
        return null;
    }

    @Override
    public void updateEmployee(final Employee content) {

    }

    @Override
    public void createEmployee(final Employee content) {

    }

    @Override
    public Employee findEmplyeeByNumber(final String Number) {
        return null;
    }
}

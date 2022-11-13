package de.thaso.demo.examples.simplepayroll.employee.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class EmployeeServiceImpl implements EmployeeService {
    private static final Logger LOGGER = Logger.getLogger("EmployeeControllerImpl");

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

package de.thaso.demo.examples.simplepayroll.employee.service;

import de.thaso.demo.examples.simplepayroll.employee.data.EmployeeDao;
import org.apache.commons.lang3.RandomStringUtils;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ApplicationScoped
public class EmployeeServiceImpl implements EmployeeService {
    private static final Logger LOGGER = Logger.getLogger(EmployeeServiceImpl.class);

    @Inject
    private EmployeeDao employeeDao;

    @Override
    public List<Employee> findAllEmployee() {
        return employeeDao.findAllEmployee();
    }

    @Override
    public void updateEmployee(final Employee content) {
        employeeDao.updateEmployee(content);
    }

    @Override
    public void createEmployee(final Employee content) {
        content.setNumber(createNextEmployeeNumber());
        employeeDao.insertEmployee(content);
    }

    @Override
    public Employee findEmplyeeByNumber(final String number) {
        return employeeDao.findEmployeeById(number);
    }

    private String createNextEmployeeNumber() {
        String result;
        do {
            result = RandomStringUtils.randomNumeric(5);
        } while (employeeDao.findEmployeeById(result) != null);
        return result;
    }
}

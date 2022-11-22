package de.thaso.demo.examples.simplepayroll.employee.service;

import de.thaso.demo.examples.simplepayroll.employee.data.EmployeeDao;
import de.thaso.demo.examples.simplepayroll.employee.kafka.EmployeeProducer;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;

@ApplicationScoped
public class EmployeeServiceImpl implements EmployeeService {
    private static final Logger LOGGER = Logger.getLogger(EmployeeServiceImpl.class);

    @Inject
    private EmployeeDao employeeDao;

    @Inject
    private EmployeeProducer employeeProducer;

    @Override
    public List<Employee> findAllEmployee() {
        return employeeDao.findAllEmployee();
    }

    @Override
    public void updateEmployee(final Employee content) {

    }

    @Override
    public void createEmployee(final Employee content) {
        LOGGER.info("createEmployee: " + content.toString());

        employeeDao.insertEmployee(content);
        employeeProducer.sendEmployee(content.getNumber(), content);
    }

    @Override
    public Employee findEmplyeeByNumber(final String Number) {
        return employeeDao.findEmployeeById(Number);
    }
}

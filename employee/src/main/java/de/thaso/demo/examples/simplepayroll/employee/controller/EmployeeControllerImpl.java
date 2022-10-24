package de.thaso.demo.examples.simplepayroll.employee.controller;

import de.thaso.demo.examples.simplepayroll.employee.boundary.EmployeeDao;
import de.thaso.demo.examples.simplepayroll.employee.boundary.EmployeeProducer;
import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

@ApplicationScoped
public class EmployeeControllerImpl implements EmployeeController {
    private static final Logger LOGGER = Logger.getLogger("EmployeeControllerImpl");

    @Inject
    private EmployeeDao employeeDao;

    @Inject
    private EmployeeProducer employeeProducer;

    public void createEmployee(final Employee employee) {
        LOGGER.info("createEmployee ...");

        employeeDao.update(employee);
        try {
            employeeProducer.sendEmployee(employee);
        } catch (ExecutionException e) {
            throw new RuntimeException(e);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } catch (TimeoutException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Employee> findAllEmployees() {
        LOGGER.info("findAllEmployees ...");

        return employeeDao.findAll().all();
    }

    public Employee findEmployee(final String number) {
        LOGGER.info("findEmployee ...");

        return null;
    }
}

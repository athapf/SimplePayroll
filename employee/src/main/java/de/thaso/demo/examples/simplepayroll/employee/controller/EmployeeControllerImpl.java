package de.thaso.demo.examples.simplepayroll.employee.controller;

import de.thaso.demo.examples.simplepayroll.employee.boundary.EmployeeDao;
import de.thaso.demo.examples.simplepayroll.employee.boundary.EmployeeProducer;
import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;

@ApplicationScoped
public class EmployeeControllerImpl implements EmployeeController {

    @Inject
    private EmployeeDao employeeDao;

    @Inject
    private EmployeeProducer employeeProducer;

    public void createEmployee(final Employee employee) {
        employeeDao.update(employee);
    }

    public List<Employee> findAllEmployees() {
        return employeeDao.findAll().all();
    }

    public Employee findEmployee(final String number) {
        return null;
    }
}

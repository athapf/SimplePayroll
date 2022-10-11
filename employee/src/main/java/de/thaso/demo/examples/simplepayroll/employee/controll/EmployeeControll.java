package de.thaso.demo.examples.simplepayroll.employee.controll;

import de.thaso.demo.examples.simplepayroll.employee.boundary.EmployeeDao;
import de.thaso.demo.examples.simplepayroll.employee.boundary.EmployeeProducer;
import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;

@ApplicationScoped
public class EmployeeControll {

    @Inject
    private EmployeeDao employeeDao;

    @Inject
    private EmployeeProducer employeeProducer;

    public Employee createEmployee(final Employee employee) {
        employeeDao.update(employee);
        return employee;
    }

    public List<Employee> findAllEmployees() {
        return employeeDao.findAll().all();
    }
}

package de.thaso.demo.examples.simplepayroll.employee.controll;

import de.thaso.demo.examples.simplepayroll.employee.boundary.EmployeeProducer;
import de.thaso.demo.examples.simplepayroll.employee.data.EmployeeDao;
import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;
import de.thaso.demo.examples.simplepayroll.employee.data.EmployeeEntity;
import de.thaso.demo.examples.simplepayroll.employee.utils.EmployeeMapper;
import de.thaso.demo.examples.simplepayroll.employee.utils.EmployeeMapperImpl;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;

@ApplicationScoped
public class EmployeeControll {

    @Inject
    private EmployeeDao employeeDao;

    @Inject
    private EmployeeProducer employeeProducer;

    private EmployeeMapperImpl employeeMapper = new EmployeeMapperImpl();

    public Employee loadEmployee(final String number) {
        return employeeMapper.employeeEntityToEmployee(employeeDao.findById(number).get());
    }

    public Employee createEmployee(final Employee employee) {
        employeeDao.save(employeeMapper.employeeToEmployeeEntity(employee));
        return employee;
    }

    public Employee updateEmployee(final Employee employee) {
        return null;
    }

    public List<Employee> findAllEmployees() {
        return employeeMapper.employeeEntityToEmployeeList(employeeDao.findAll().all());
    }
}

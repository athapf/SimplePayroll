package de.thaso.demo.examples.simplepayroll.employee.utils;

import de.thaso.demo.examples.simplepayroll.employee.data.EmployeeEntity;
import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    Employee employeeEntityToEmployee(final EmployeeEntity employeeEntity);
    EmployeeEntity employeeToEmployeeEntity(final Employee employee);
    List<Employee> employeeEntityToEmployeeList(final List<EmployeeEntity> employeeEntity);
    List<EmployeeEntity> employeeToEmployeeEntityList(final List<Employee> employee);
}

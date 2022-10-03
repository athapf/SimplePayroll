package de.thaso.demo.examples.simplepayroll.employee.data;

import com.datastax.oss.driver.api.mapper.annotations.DaoFactory;
import com.datastax.oss.driver.api.mapper.annotations.Mapper;

@Mapper
public interface EmployeeMapper {

    @DaoFactory
    EmployeeDao employeeDao();
}

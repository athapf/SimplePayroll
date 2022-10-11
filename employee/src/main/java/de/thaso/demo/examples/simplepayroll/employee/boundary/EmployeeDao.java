package de.thaso.demo.examples.simplepayroll.employee.boundary;

import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;
import com.datastax.oss.driver.api.core.PagingIterable;
import com.datastax.oss.driver.api.mapper.annotations.Dao;
import com.datastax.oss.driver.api.mapper.annotations.Select;
import com.datastax.oss.driver.api.mapper.annotations.Update;

@Dao
public interface EmployeeDao {
  @Update
  void update(Employee employee);

  @Select
  PagingIterable<Employee> findAll();
}
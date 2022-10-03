package de.thaso.demo.examples.simplepayroll.employee.data;

import com.datastax.oss.driver.api.core.PagingIterable;
import com.datastax.oss.driver.api.mapper.annotations.Dao;
import com.datastax.oss.driver.api.mapper.annotations.Delete;
import com.datastax.oss.driver.api.mapper.annotations.Insert;
import com.datastax.oss.driver.api.mapper.annotations.Select;

import java.util.Optional;

@Dao
public interface EmployeeDao {

    @Delete(entityClass = EmployeeEntity.class)
    void deleteByCol1(final String number);

    @Select
    PagingIterable<EmployeeEntity> findByName(final String name);

    @Select
    PagingIterable<EmployeeEntity> findAll();

    @Select
    Optional<EmployeeEntity> findById(final String number);

    @Insert
    void save(EmployeeEntity employee);
}

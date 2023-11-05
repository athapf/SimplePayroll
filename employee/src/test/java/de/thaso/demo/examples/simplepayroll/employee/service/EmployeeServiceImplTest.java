package de.thaso.demo.examples.simplepayroll.employee.service;

import de.thaso.demo.examples.simplepayroll.employee.data.EmployeeDao;
import org.apache.commons.lang3.RandomStringUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.math.BigDecimal;

import static org.hamcrest.CoreMatchers.notNullValue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.MockitoAnnotations.openMocks;

class EmployeeServiceImplTest {

    @InjectMocks
    private EmployeeServiceImpl underTest;

    @Mock
    private EmployeeDao employeeDao;

    @BeforeEach
    void setUp() {
        openMocks(this);
    }

    @Test
    public void createEmployee() {
        // given
        final Employee employee = Employee.builder()
                .withIban(RandomStringUtils.randomAlphabetic(15))
                .withName(RandomStringUtils.randomAlphabetic(10))
                .withWagerate(new BigDecimal("18.73"))
                .build();
        final ArgumentCaptor<Employee> employeeArgumentCaptor = ArgumentCaptor.forClass(Employee.class);
        // when
        underTest.createEmployee(employee);
        // then
        verify(employeeDao).insertEmployee(employeeArgumentCaptor.capture());
        final Employee argumentCaptorValue = employeeArgumentCaptor.getValue();
        assertThat(argumentCaptorValue.getNumber(), notNullValue());
    }
}

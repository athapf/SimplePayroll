package de.thaso.demo.examples.simplepayroll.employee.boundary;

import de.thaso.demo.examples.simplepayroll.employee.controll.EmployeeControll;
import de.thaso.demo.examples.simplepayroll.employee.entity.Employee;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/employees")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@ApplicationScoped
public class EmployeesResource {

    @Inject
    private EmployeeControll employeeControll;

    @GET
    public List<Employee> findAllEmnployees() {
        System.out.printf("find all employees\n");
        return employeeControll.findAllEmployees();
    }

    @POST
    public Employee createEmployee(final Employee employee) {
        System.out.printf("create employee\n");

        return employeeControll.createEmployee(employee);
    }
}

package de.thaso.demo.examples.simplepayroll.employee.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;

@Path("/employee")
@Consumes(MediaType.APPLICATION_JSON)
@ApplicationScoped
public class EmployeeResource {

private static final Logger LOGGER = Logger.getLogger(EmployeeResource.class);

    @Inject
    private EmployeeProducer employeeProducer;

    @PUT
    public void createEmployee(final Employee employee) {
        LOGGER.info("createEmployee ...");
        employeeProducer.sendEmployee(employee.getNumber(), employee);
    }
}

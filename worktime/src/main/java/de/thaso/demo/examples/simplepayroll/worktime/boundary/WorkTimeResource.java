package de.thaso.demo.examples.simplepayroll.worktime.boundary;

import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/worktime")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@ApplicationScoped
public class WorkTimeResource {

    @GET
    @Path("/reset")
    public String doReset() {
        System.out.println("reset average");
        return "done";
    }
}

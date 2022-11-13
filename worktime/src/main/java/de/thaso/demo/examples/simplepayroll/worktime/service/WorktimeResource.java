package de.thaso.demo.examples.simplepayroll.worktime.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;

@Path("/worktime")
@Consumes(MediaType.APPLICATION_JSON)
@ApplicationScoped
public class WorktimeResource {

private static final Logger LOGGER = Logger.getLogger(WorktimeResource.class);

    @Inject
    private WorktimeProducer worktimeProducer;

    @PUT
    public void createWorktime(final Worktime worktime) {
        LOGGER.info("createWorktime: " + worktime.toString());
        worktimeProducer.sendWorktime(worktime.getNumber(), worktime);
    }
}

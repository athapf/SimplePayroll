package de.thaso.demo.examples.simplepayroll.worktime.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class WorktimeServiceImpl implements WorktimeService {
    private static final Logger LOGGER = Logger.getLogger(WorktimeServiceImpl.class);

    @Override
    public List<Worktime> findAllWorktime() {
        return null;
    }

    @Override
    public Worktime updateWorktime(final Worktime content) {
        return null;
    }

    @Override


    public Worktime createWorktime(final Worktime content) {
        return null;
    }

    @Override
    public void consumeEmployee(final String key, final Employee payload) {
        LOGGER.info("==> consume employee : " + key + ", " + payload.getNumber());
    }
}

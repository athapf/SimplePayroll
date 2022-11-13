package de.thaso.demo.examples.simplepayroll.worktime.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class WorktimeServiceImpl implements WorktimeService {
    private static final Logger LOGGER = Logger.getLogger("WorktimeControllerImpl");

    @Override
    public List<Worktime> findAllWorktime() {
        return null;
    }

    @Override
    public void updateWorktime(final Worktime content) {

    }

    @Override
    public void createWorktime(final Worktime content) {

    }

    @Override
    public void consumeEmployee(final String key, final Employee payload) {

    }
}

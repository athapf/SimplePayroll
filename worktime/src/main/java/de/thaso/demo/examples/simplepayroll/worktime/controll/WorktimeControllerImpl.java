package de.thaso.demo.examples.simplepayroll.worktime.controll;

import de.thaso.demo.examples.simplepayroll.worktime.boundary.WorktimeDao;
import de.thaso.demo.examples.simplepayroll.worktime.controller.WorktimeController;
import de.thaso.demo.examples.simplepayroll.worktime.entity.Worktime;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;

@ApplicationScoped
public class WorktimeControllerImpl implements WorktimeController {
    private static final Logger LOGGER = Logger.getLogger("WorktimeControllerImpl");

    @Inject
    private WorktimeDao worktimeDao;

    @Override
    public void doReset() {
    }

    @Override
    public void consumeWorktime(final Worktime value) {
        LOGGER.info("consumeWorkTime ...");
        worktimeDao.update(value);
    }
}

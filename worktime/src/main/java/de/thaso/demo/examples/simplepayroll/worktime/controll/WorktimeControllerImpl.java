package de.thaso.demo.examples.simplepayroll.worktime.controll;

import de.thaso.demo.examples.simplepayroll.worktime.boundary.WorktimeDao;
import de.thaso.demo.examples.simplepayroll.worktime.controller.WorktimeController;
import de.thaso.demo.examples.simplepayroll.worktime.entity.Worktime;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;

@ApplicationScoped
public class WorktimeControllerImpl implements WorktimeController {

    @Inject
    private WorktimeDao worktimeDao;

    @Override
    public void doReset() {
    }
}

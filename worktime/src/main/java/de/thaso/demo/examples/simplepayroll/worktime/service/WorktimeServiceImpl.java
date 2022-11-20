package de.thaso.demo.examples.simplepayroll.worktime.service;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class WorktimeServiceImpl implements WorktimeService {
    @Override
    public List<Worktime> findAllWorktime() {
        return null;
    }

    @Override
    public void updateWorktime(Worktime content) {

    }

    @Override
    public void createWorktime(Worktime content) {

    }

    @Override
    public void consumeEmployee(String key, Employee payload) {

    }
}

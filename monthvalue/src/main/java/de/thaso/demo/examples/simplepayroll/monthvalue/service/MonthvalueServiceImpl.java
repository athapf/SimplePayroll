package de.thaso.demo.examples.simplepayroll.monthvalue.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class MonthvalueServiceImpl implements MonthvalueService {
    private static final Logger LOGGER = Logger.getLogger(MonthvalueServiceImpl.class);

    @Override
    public List<Monthvalue> findAllMonthvalue() {
        return null;
    }

    @Override
    public void employeeWorktime(final String key, final Employee payload) {

    }

    @Override
    public void consumeWorktime(final String key, final Worktime payload) {

    }
}

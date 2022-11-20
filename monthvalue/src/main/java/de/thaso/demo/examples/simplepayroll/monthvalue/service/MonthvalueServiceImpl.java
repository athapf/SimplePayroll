package de.thaso.demo.examples.simplepayroll.monthvalue.service;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class MonthvalueServiceImpl implements MonthvalueService {
    @Override
    public List<Monthvalue> findAllMonthvalue() {
        return null;
    }

    @Override
    public void consumeWorktime(String key, Worktime payload) {

    }
}

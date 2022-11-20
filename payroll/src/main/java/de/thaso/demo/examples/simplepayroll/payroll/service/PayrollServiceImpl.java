package de.thaso.demo.examples.simplepayroll.payroll.service;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class PayrollServiceImpl implements PayrollService {
    @Override
    public List<Payroll> findAllPayroll() {
        return null;
    }

    @Override
    public void consumePayroll(String key, Monthvalue payload) {

    }
}

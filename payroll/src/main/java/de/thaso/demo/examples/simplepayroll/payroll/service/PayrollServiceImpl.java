package de.thaso.demo.examples.simplepayroll.payroll.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class PayrollServiceImpl implements PayrollService {
    private static final Logger LOGGER = Logger.getLogger(PayrollServiceImpl.class);

    @Override
    public List<Payroll> findAllPayroll() {
        return null;
    }

    @Override
    public void consumeMonthvalue(final String key, final Monthvalue payload) {

    }

    @Override
    public void consumeCareamount(final String key, final Careamount payload) {

    }
}

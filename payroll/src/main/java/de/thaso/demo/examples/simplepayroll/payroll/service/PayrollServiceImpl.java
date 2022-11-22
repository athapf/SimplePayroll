package de.thaso.demo.examples.simplepayroll.payroll.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.List;

@ApplicationScoped
public class PayrollServiceImpl implements PayrollService {
    private static final Logger LOGGER = Logger.getLogger(PayrollServiceImpl.class);

    @Inject
    private ObjectMapper objectMapper;

    @Override
    public List<Payroll> findAllPayroll() {
        return null;
    }

    @Override
    public void consumeMonthvalue(final String key, final Monthvalue payload) {
        LOGGER.info("consumeMonthvalue: " + payload.toString());
    }

    @Override
    public void consumeCareamount(final String key, final Careamount payload) {
        LOGGER.info("consumeCareamount: " + payload.toString());
    }
}

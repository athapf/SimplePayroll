package de.thaso.demo.examples.simplepayroll.transferdata.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class TransferdataServiceImpl implements TransferdataService {
    private static final Logger LOGGER = Logger.getLogger(TransferdataServiceImpl.class);

    @Override
    public List<Transferdata> findAllTransferdata() {
        return null;
    }

    @Override
    public void consumeEmployee(final String key, final Employee payload) {

    }

    @Override
    public void consumePayroll(final String key, final Payroll payload) {

    }
}

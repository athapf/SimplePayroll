package de.thaso.demo.examples.simplepayroll.caredata.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class CaredataServiceImpl implements CaredataService {
    private static final Logger LOGGER = Logger.getLogger(CaredataServiceImpl.class);

    @Override
    public List<Caredata> findAllCaredata() {
        return null;
    }

    @Override
    public void startCaredata(final Createcaredata content) {

    }

    @Override
    public void consumeEmployee(final String key, final Employee payload) {

    }

    @Override
    public void consumePayroll(final String key, final Payroll payload) {

    }
}

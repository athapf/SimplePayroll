package de.thaso.demo.examples.simplepayroll.carereport.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class CarereportServiceImpl implements CarereportService {
    private static final Logger LOGGER = Logger.getLogger(CarereportServiceImpl.class);

    @Override
    public List<Carereport> findAllCarereport() {
        return null;
    }

    @Override
    public void consumeCaredata(final String key, final Caredata payload) {

    }
}

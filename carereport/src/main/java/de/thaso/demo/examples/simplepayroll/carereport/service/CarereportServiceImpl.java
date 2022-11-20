package de.thaso.demo.examples.simplepayroll.carereport.service;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class CarereportServiceImpl implements CarereportService {
    @Override
    public List<Carereport> findAllCarereport() {
        return null;
    }

    @Override
    public void consumeCaredata(final String key, final Caredata payload) {

    }
}

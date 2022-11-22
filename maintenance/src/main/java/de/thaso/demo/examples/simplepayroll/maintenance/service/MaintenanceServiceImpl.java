package de.thaso.demo.examples.simplepayroll.maintenance.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class MaintenanceServiceImpl implements MaintenanceService {
    private static final Logger LOGGER = Logger.getLogger(MaintenanceServiceImpl.class);

    @Override
    public void startPayroll(final Maintenance content) {

    }
}

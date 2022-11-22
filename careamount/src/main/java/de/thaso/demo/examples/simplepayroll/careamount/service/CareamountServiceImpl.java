package de.thaso.demo.examples.simplepayroll.careamount.service;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class CareamountServiceImpl implements CareamountService {
    private static final Logger LOGGER = Logger.getLogger(CareamountServiceImpl.class);

    @Override
    public List<Careamount> findAllCareamount() {
        return null;
    }

    @Override
    public void consumeMonthvalue(final String key, final Monthvalue payload) {

    }
}

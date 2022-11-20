package de.thaso.demo.examples.simplepayroll.careamount.service;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class CareamountServiceImpl implements CareamountService {
    @Override
    public List<Careamount> findAllCareamount() {
        return null;
    }

    @Override
    public void consumeMonthvalue(final String key, final Monthvalue payload) {

    }
}

package de.thaso.demo.examples.simplepayroll.careamount.service;

import de.thaso.demo.examples.simplepayroll.careamount.data.CareamountDao;
import de.thaso.demo.examples.simplepayroll.careamount.kafka.CareamountProducer;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.math.BigDecimal;
import java.util.List;

@ApplicationScoped
public class CareamountServiceImpl implements CareamountService {
    private static final Logger LOGGER = Logger.getLogger(CareamountServiceImpl.class);

    @Inject
    private CareamountDao careamountDao;

    @Inject
    private CareamountProducer careamountProducer;

    @Override
    public List<Careamount> findAllCareamount() {
        return null;
    }

    @Override
    public void consumeMonthvalue(final String key, final Monthvalue payload) {
        LOGGER.info("consumeMonthvalue: " + payload.toString());

        final String id = payload.getNumber() + payload.getYear() + payload.getMonth();
        Careamount careamount = careamountDao.findCareamountById(id);
        if(careamount == null) {
            careamount = Careamount.builder()
                    .withId(id)
                    .withNumber(payload.getNumber())
                    .withYear(payload.getYear())
                    .withMonth(payload.getMonth())
                    .withTotal(BigDecimal.ZERO)
                    .build();
            careamountDao.insertCareamount(careamount);
        }
        careamount.setTotal(payload.getGrosssalery().multiply(new BigDecimal("1.95")));
        careamountDao.updateCareamount(careamount);
    }
}

package de.thaso.demo.examples.simplepayroll.monthvalue.service;

import de.thaso.demo.examples.simplepayroll.monthvalue.data.EmployeeDao;
import de.thaso.demo.examples.simplepayroll.monthvalue.data.MonthvalueDao;
import de.thaso.demo.examples.simplepayroll.monthvalue.data.WorktimeDao;
import de.thaso.demo.examples.simplepayroll.monthvalue.kafka.MonthvalueProducer;
import org.apache.commons.lang3.time.FastDateFormat;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@ApplicationScoped
public class MonthvalueServiceImpl implements MonthvalueService {
    private static final Logger LOGGER = Logger.getLogger(MonthvalueServiceImpl.class);

    @Inject
    private MonthvalueDao monthvalueDao;

    @Inject
    private WorktimeDao worktimeDao;

    @Inject
    private EmployeeDao employeeDao;

    @Inject
    private MonthvalueProducer monthvalueProducer;

    private FastDateFormat fastDateFormat = FastDateFormat.getInstance("yyyy-MM-dd");

    @Override
    public List<Monthvalue> findAllMonthvalue() {
        return monthvalueDao.findAllMonthvalue();
    }

    @Override
    public void employeeWorktime(final String key, final Employee payload) {
        LOGGER.info("employeeWorktime: " + payload.toString());

        employeeDao.insertEmployee(payload);
    }

    @Override
    public void consumeWorktime(final String key, final Worktime payload) {
        LOGGER.info("consumeWorktime: " + payload.toString());

        payload.setYear(Integer.parseInt(payload.getDate().substring(0,4)));
        payload.setMonth(Integer.parseInt(payload.getDate().substring(5,7)));
        final Worktime worktime = worktimeDao.findWorktimeById(key);
        if(worktime == null) {
            worktimeDao.insertWorktime(payload);
        } else {
            worktimeDao.updateWorktime(payload);
        }

        String id = payload.getNumber() + payload.getYear() + payload.getMonth();

        final Employee employee = employeeDao.findEmployeeById(payload.getNumber());
        BigDecimal total = BigDecimal.ZERO;
        if(employee != null) {
            total = employee.getWagerate().multiply(payload.getHour());
        }

        Monthvalue monthvalue = monthvalueDao.findMonthvalueById(id);
        if(monthvalue == null) {
            monthvalue = Monthvalue.builder()
                    .withId(id)
                    .withNumber(payload.getNumber())
                    .withYear(payload.getYear())
                    .withMonth(payload.getMonth())
                    .withHour(payload.getHour())
                    .withDifference(BigDecimal.ZERO)
                    .withGrosssalery(total)
                    .withCreatedon(fastDateFormat.format(new Date()))
                    .build();
            monthvalueDao.insertMonthvalue(monthvalue);
        } else {
            monthvalue.setHour(monthvalue.getHour().add(payload.getDifference()));
            monthvalue.setDifference(payload.getDifference());
            monthvalue.setGrosssalery(total);
            monthvalue.setCreatedon(fastDateFormat.format(new Date()));
            monthvalueDao.updateMonthvalue(monthvalue);
        }
        monthvalueProducer.sendMonthvalue(id,monthvalue);
    }
}

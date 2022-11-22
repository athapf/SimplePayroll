package de.thaso.demo.examples.simplepayroll.worktime.service;

import de.thaso.demo.examples.simplepayroll.worktime.data.EmployeeDao;
import de.thaso.demo.examples.simplepayroll.worktime.data.WorktimeDao;
import de.thaso.demo.examples.simplepayroll.worktime.kafka.WorktimeProducer;
import org.apache.commons.lang3.time.FastDateFormat;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class WorktimeServiceImpl implements WorktimeService {
    private static final Logger LOGGER = Logger.getLogger(WorktimeServiceImpl.class);

    @Inject
    private WorktimeDao worktimeDao;

    @Inject
    private EmployeeDao employeeDao;

    @Inject
    private WorktimeProducer worktimeProducer;

    private FastDateFormat fastDateFormat = FastDateFormat.getInstance("yyyy-MM-dd");

    @Override
    public List<Worktime> findAllWorktime() {
        return worktimeDao.findAllWorktime();
    }

    @Override
    public Worktime updateWorktime(Worktime content) {
        LOGGER.info("updateWorktime: " + content.toString());

        final Worktime worktime = worktimeDao.findWorktimeById(content.getId());
        content.setCreatedon(fastDateFormat.format(new Date()));
        content.setDifference(content.getHour().subtract(worktime.getHour()));
        worktimeDao.updateWorktime(content);
        worktimeProducer.sendWorktime(content.getNumber(), content);
        return content;
    }

    @Override
    public Worktime createWorktime(Worktime content) {
        LOGGER.info("createWorktime: " + content.toString());

        content.setId(UUID.randomUUID().toString());
        content.setCreatedon(fastDateFormat.format(new Date()));
        content.setDifference(BigDecimal.ZERO);
        worktimeDao.insertWorktime(content);
        worktimeProducer.sendWorktime(content.getNumber(), content);
        return content;
    }

    @Override
    public void consumeEmployee(String key, Employee payload) {
        employeeDao.insertEmployee(payload);
    }
}

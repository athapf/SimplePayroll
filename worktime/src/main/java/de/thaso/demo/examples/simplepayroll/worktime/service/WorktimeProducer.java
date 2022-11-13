package de.thaso.demo.examples.simplepayroll.worktime.service;

import io.smallrye.reactive.messaging.kafka.Record;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class WorktimeProducer {
    private static final Logger LOGGER = Logger.getLogger(WorktimeProducer.class);

/*
    @Channel("worktime")
    private Emitter<Record<String, Worktime>> worktimeDtoEmitter;
*/

    @Channel("worktime")
    private Emitter<Worktime> worktimeDtoEmitter;

    public Worktime sendWorktime(final Worktime worktime) {
        LOGGER.info("sendWorktime: " + worktime.toString());
        worktimeDtoEmitter.send(worktime);
//        worktimeDtoEmitter.send(Record.of(key, worktime));
        return worktime;
    }
}

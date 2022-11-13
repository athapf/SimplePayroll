package de.thaso.demo.examples.simplepayroll.monthvalue.service;

import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import io.smallrye.reactive.messaging.kafka.Record;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.eclipse.microprofile.reactive.messaging.Outgoing;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@ApplicationScoped
public class WorktimeProcessor {
    private static final Logger LOGGER = Logger.getLogger(WorktimeProcessor.class);

    private Map<Date, BigDecimal> store = new HashMap<>();

    @Incoming("worktime")
    @Outgoing("monthvalue")
    public Multi<Monthvalue> processWorktime(final Multi<Worktime> worktime) {
        return worktime
                .onItem().call(element -> storeWorktime(element))
                .onItem().transform(element -> transform(element));
    }

    private Monthvalue transform(final Worktime element) {
        LOGGER.info("transform: " + element.toString());

        BigDecimal sum = BigDecimal.ZERO;
        for(BigDecimal item : store.values()) {
            sum = sum.add(item);
        }
        LOGGER.info("transform: sum = " + sum.toString());

        return Monthvalue.builder()
                .withCreatedon(new Date())
                .withHour(sum)
                .withMonth(element.getDate().getMonth() + 1)
                .withYear(element.getDate().getYear())
                .withNumber(element.getNumber())
                .build();
    }

    private Uni<Worktime> storeWorktime(final Worktime element) {
        LOGGER.info("storeWorktime: " + element.toString());

        store.put(element.getDate(),element.getHour());
        LOGGER.info("in store: " + store.size());
        return Uni.createFrom().item(element);
    }

/*
    @Incoming("worktime")
    @Outgoing("monthvalue")
    public Multi<Record<String, Monthvalue>> processWorktime(final Multi<KafkaRecord<String, Worktime>> worktimeRecord) {
        return worktimeRecord
                .onItem().call(element -> storeWorktimeRecord(element))
                .onItem().transform(element -> transformRecord(element));
    }
*/

    private Record<String, Monthvalue> transformRecord(final KafkaRecord<String, Worktime> element) {

        BigDecimal sum = BigDecimal.ZERO;
        for(BigDecimal item : store.values()) {
            sum = sum.add(item);
        }

        return Record.of(element.getKey(),
                Monthvalue.builder()
                        .withCreatedon(new Date())
                        .withHour(sum)
                        .withMonth(element.getPayload().getDate().getMonth() + 1)
                        .withYear(element.getPayload().getDate().getYear())
                        .withNumber(element.getKey())
                        .build());
    }

    private Uni<KafkaRecord<String, Worktime>> storeWorktimeRecord(final KafkaRecord<String, Worktime> element) {
        LOGGER.info("storeWorktime: " + element.getPayload().toString());

        final Worktime payload = element.getPayload();
        store.put(payload.getDate(),payload.getHour());
        LOGGER.info("in store: " + store.size());
        return Uni.createFrom().item(element);
    }
}

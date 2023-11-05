package de.thaso.demo.examples.simplepayroll.worktime.pact;

import au.com.dius.pact.consumer.MessagePactBuilder;
import au.com.dius.pact.consumer.dsl.PactDslJsonBody;
import au.com.dius.pact.consumer.junit5.PactConsumerTestExt;
import au.com.dius.pact.consumer.junit5.PactTestFor;
import au.com.dius.pact.consumer.junit5.ProviderType;
import au.com.dius.pact.core.model.PactSpecVersion;
import au.com.dius.pact.core.model.V4Interaction;
import au.com.dius.pact.core.model.V4Pact;
import au.com.dius.pact.core.model.annotations.Pact;
import com.fasterxml.jackson.databind.ObjectMapper;
import de.thaso.demo.examples.simplepayroll.worktime.kafka.EmployeeConsumer;
import de.thaso.demo.examples.simplepayroll.worktime.kafka.dto.EmployeeDto;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasEntry;

@ExtendWith(PactConsumerTestExt.class)
@ExtendWith(MockitoExtension.class)
@PactTestFor(providerName = "simplepayroll-employee", providerType = ProviderType.ASYNCH, pactVersion = PactSpecVersion.V4)
public class EmployeeConsumerPactTest {
    private final static Logger LOGGER = LoggerFactory.getLogger(EmployeeConsumerPactTest.class);

    @InjectMocks
    private EmployeeConsumer underTest;

    private ObjectMapper mapper = new ObjectMapper();

    @Pact(consumer = "simplepayroll-worktime")
    V4Pact createPact(MessagePactBuilder pactBuilder) {
        return pactBuilder
            .given("createEmployee")
            .expectsToReceive("neuer  Mitarbeiter")
            .withMetadata(metadata -> {
                metadata.add("eventType", "eingestellt");
            })
            .withContent(new PactDslJsonBody()
                .stringType("number", "84363")
                .stringType("name", "Manfred Müller")
                .decimalType("weeklyhours", new BigDecimal("37.5"))
                .decimalType("wagerate", new BigDecimal("28.93"))
            .asBody())
        .toPact();
    }

    @Test
    @DisplayName("neuer Mitarbeiter eingestellt")
    @PactTestFor(pactMethod = "createPact")
    void neuerMitarbeiter(V4Interaction.AsynchronousMessage message) throws Exception {
        // when
        EmployeeDto employeeDto = mapper.readValue(message.contentsAsBytes(), EmployeeDto.class);
        // then
        assertThat(employeeDto.getNumber(), is("84363"));
        assertThat(employeeDto.getName(), is("Manfred Müller"));
        assertThat(employeeDto.getWeeklyhours(), is(new BigDecimal("37.5")));
        assertThat(employeeDto.getWagerate(), is(new BigDecimal("28.93")));

        assertThat(message.getMetadata(), hasEntry("eventType", "eingestellt"));
    }
}

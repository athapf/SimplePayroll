<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package"
                  select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="consumer" mode="topic">
        <xsl:variable name="filename"
                      select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/boundary/',./@entity,'Consumer.java')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.boundary;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.entity.</xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>import io.quarkus.runtime.ShutdownEvent;&#xA;</xsl:text>
            <xsl:text>import io.quarkus.runtime.StartupEvent;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.clients.consumer.ConsumerRecords;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import javax.enterprise.event.Observes;&#xA;</xsl:text>
            <xsl:text>import javax.inject.Inject;&#xA;</xsl:text>
            <xsl:text>import java.time.Duration;&#xA;</xsl:text>
            <xsl:text>import java.util.Collections;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>Consumer {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public static final String TOPIC = "values";&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @Inject&#xA;</xsl:text>
            <xsl:text>    org.apache.kafka.clients.consumer.KafkaConsumer&lt;String, </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>&gt; consumer;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    volatile boolean done = false;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public void initialize(@Observes StartupEvent ev) {&#xA;</xsl:text>
            <xsl:text>        consumer.subscribe(Collections.singleton(TOPIC));&#xA;</xsl:text>
            <xsl:text>        new Thread(() -> {&#xA;</xsl:text>
            <xsl:text>            while (! done) {&#xA;</xsl:text>
            <xsl:text>                final ConsumerRecords&lt;String, </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>&gt; consumerRecords = consumer.poll(Duration.ofSeconds(1));&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>                consumerRecords.forEach(record -> {&#xA;</xsl:text>
            <xsl:text>                    final </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text> value = record.value();&#xA;</xsl:text>
            <xsl:text>                    process(value);&#xA;</xsl:text>
            <xsl:text>                });&#xA;</xsl:text>
            <xsl:text>            }&#xA;</xsl:text>
            <xsl:text>            consumer.close();&#xA;</xsl:text>
            <xsl:text>        }).start();&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    private void process(final </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text> value) {&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public void terminate(@Observes ShutdownEvent ev) {&#xA;</xsl:text>
            <xsl:text>        done = false;&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

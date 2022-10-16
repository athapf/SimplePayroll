<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package" select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="producer" mode="topic">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/boundary/',./@entity,'Producer.java')"/>
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
            <xsl:text>import org.apache.kafka.clients.producer.KafkaProducer;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.clients.producer.ProducerRecord;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import javax.enterprise.event.Observes;&#xA;</xsl:text>
            <xsl:text>import javax.inject.Inject;&#xA;</xsl:text>
            <xsl:text>import java.util.concurrent.ExecutionException;&#xA;</xsl:text>
            <xsl:text>import java.util.concurrent.TimeUnit;&#xA;</xsl:text>
            <xsl:text>import java.util.concurrent.TimeoutException;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>Producer {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public static final String TOPIC = "</xsl:text>
            <xsl:value-of select="./@topic"/>
            <xsl:text>";&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @Inject&#xA;</xsl:text>
            <xsl:text>    KafkaProducer&lt;String, </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>&gt; producer;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public void terminate(@Observes ShutdownEvent ev) {&#xA;</xsl:text>
            <xsl:text>        producer.close();&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text> send</xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>(final </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text> value)&#xA;</xsl:text>
            <xsl:text>            throws ExecutionException, InterruptedException, TimeoutException {&#xA;</xsl:text>
            <xsl:text>        producer.send(new ProducerRecord&lt;&gt;(TOPIC, "value", value))&#xA;</xsl:text>
            <xsl:text>                .get(5, TimeUnit.SECONDS);&#xA;</xsl:text>
            <xsl:text>        return value;&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="producer.xslt"/>
    <xsl:import href="serializer.xslt"/>
    <xsl:import href="consumer.xslt"/>
    <xsl:import href="deserializer.xslt"/>

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package" select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="producer|consumer" mode="import">
        <xsl:text>import </xsl:text>
        <xsl:value-of select="$package"/>
        <xsl:text>.entity.</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>;&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="producer" mode="cdi-producer">
        <xsl:text>    @Produces&#xA;</xsl:text>
        <xsl:text>    KafkaProducer&lt;String, </xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>&gt; getProducer() {&#xA;</xsl:text>
        <xsl:text>        return new KafkaProducer&lt;&gt;(config,&#xA;</xsl:text>
        <xsl:text>                new StringSerializer(),&#xA;</xsl:text>
        <xsl:text>                new </xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Serializer());&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="consumer" mode="cdi-producer">
        <xsl:text>    @Produces&#xA;</xsl:text>
        <xsl:text>    KafkaConsumer&lt;String, </xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>&gt; getConsumer() {&#xA;</xsl:text>
        <xsl:text>        return new KafkaConsumer&lt;&gt;(config,&#xA;</xsl:text>
        <xsl:text>                new StringDeserializer(),&#xA;</xsl:text>
        <xsl:text>                new </xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Deserializer());&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="topics">
        <xsl:apply-templates select="./producer" mode="topic"/>
        <xsl:apply-templates select="./producer" mode="converter"/>
        <xsl:apply-templates select="./consumer" mode="topic"/>
        <xsl:apply-templates select="./consumer" mode="converter"/>

        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/utils/KafkaProviders.java')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.utils;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="./producer" mode="import"/>
            <xsl:apply-templates select="./consumer" mode="import"/>
            <xsl:text>import io.smallrye.common.annotation.Identifier;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.clients.producer.KafkaProducer;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.common.serialization.StringSerializer;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.common.serialization.IntegerSerializer;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.clients.consumer.KafkaConsumer;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.common.serialization.IntegerDeserializer;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.common.serialization.StringDeserializer;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import javax.enterprise.context.ApplicationScoped;&#xA;</xsl:text>
            <xsl:text>import javax.enterprise.inject.Produces;&#xA;</xsl:text>
            <xsl:text>import javax.inject.Inject;&#xA;</xsl:text>
            <xsl:text>import java.util.Map;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@ApplicationScoped&#xA;</xsl:text>
            <xsl:text>public class KafkaProviders {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @Inject&#xA;</xsl:text>
            <xsl:text>    @Identifier("default-kafka-broker")&#xA;</xsl:text>
            <xsl:text>    Map&lt;String, Object&gt; config;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="./producer" mode="cdi-producer"/>
            <xsl:apply-templates select="./consumer" mode="cdi-producer"/>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package"
                  select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="consumer" mode="converter">
        <xsl:variable name="filename"
                      select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/utils/',./@entity,'Deserializer.java')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.utils;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.entity.</xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.fasterxml.jackson.databind.ObjectMapper;&#xA;</xsl:text>
            <xsl:text>import org.apache.kafka.common.serialization.Deserializer;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import java.io.IOException;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>Deserializer implements Deserializer&lt;</xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>&gt; {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @Override&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text> deserialize(String topic, byte[] bytes) {&#xA;</xsl:text>
            <xsl:text>        final ObjectMapper mapper = new ObjectMapper();&#xA;</xsl:text>
            <xsl:text>        try {&#xA;</xsl:text>
            <xsl:text>            return mapper.readValue(bytes, </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>.class);&#xA;</xsl:text>
            <xsl:text>        } catch (IOException e) {&#xA;</xsl:text>
            <xsl:text>            throw new RuntimeException(e);&#xA;</xsl:text>
            <xsl:text>        }&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

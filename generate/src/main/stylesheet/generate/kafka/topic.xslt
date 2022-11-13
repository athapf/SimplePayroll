<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="imports">
        <xsl:param name="dto-package-prefix"/>
        <xsl:param name="utils-package-prefix"/>
        <xsl:param name="service-package-prefix"/>

        <xsl:choose>
            <xsl:when test="name() = 'consumer'">
                <xsl:text>import org.eclipse.microprofile.reactive.messaging.Incoming;&#xA;</xsl:text>
            </xsl:when>
            <xsl:when test="name() = 'producer'">
                <xsl:text>import org.eclipse.microprofile.reactive.messaging.Channel;&#xA;</xsl:text>
                <xsl:if test="./@object='record'">
                    <xsl:text>import org.eclipse.microprofile.reactive.messaging.Emitter;&#xA;</xsl:text>
                    <xsl:text>import io.smallrye.reactive.messaging.kafka.Record;&#xA;</xsl:text>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
        <xsl:text>import </xsl:text>
        <xsl:value-of select="$dto-package-prefix"/>
        <xsl:value-of select="./dto/@name"/>
        <xsl:text>Dto;&#xA;</xsl:text>
        <xsl:text>import </xsl:text>
        <xsl:value-of select="$utils-package-prefix"/>
        <xsl:value-of select="./dto/@name"/>
        <xsl:text>Mapper;&#xA;</xsl:text>
        <xsl:text>import </xsl:text>
        <xsl:value-of select="$service-package-prefix"/>
        <xsl:value-of select="./dto/@entity"/>
        <xsl:text>;&#xA;</xsl:text>
        <xsl:if test="./@service">
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$service-package-prefix"/>
            <xsl:value-of select="./@service"/>
            <xsl:text>;&#xA;</xsl:text>
        </xsl:if>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="variables">
        <xsl:if test="./@service">
            <xsl:text>    @Inject&#xA;</xsl:text>
            <xsl:text>    private </xsl:text>
            <xsl:value-of select="./@service"/>
            <xsl:text> </xsl:text>
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@service"/>
            </xsl:call-template>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
        <xsl:text>    @Inject&#xA;</xsl:text>
        <xsl:text>    private </xsl:text>
        <xsl:value-of select="./dto/@name"/>
        <xsl:text>Mapper </xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./dto/@name"/>
        </xsl:call-template>
        <xsl:text>Mapper;&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="consumer-method">
        <xsl:text>    @Blocking&#xA;</xsl:text>
        <xsl:text>    @Incoming("</xsl:text>
        <xsl:value-of select="./@topic"/>
        <xsl:text>")&#xA;</xsl:text>
        <xsl:text>    public CompletionStage&lt;Void&gt; </xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(final KafkaRecord&lt;</xsl:text>
        <xsl:value-of select="./@key"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="concat(./dto/@name,'Dto')"/>
        <xsl:text>&gt; kafkaRecord) {&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>        </xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./@service"/>
        </xsl:call-template>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(kafkaRecord.getKey(), </xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./dto/@name"/>
        </xsl:call-template>
        <xsl:text>Mapper.</xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./dto/@name"/>
        </xsl:call-template>
        <xsl:text>DtoTo</xsl:text>
        <xsl:value-of select="./dto/@entity"/>
        <xsl:text>(kafkaRecord.getPayload()));&#xA;</xsl:text>
        <xsl:text>        return kafkaRecord.ack();&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="producer-method">
        <xsl:text>    @Channel("</xsl:text>
        <xsl:value-of select="./@topic"/>
        <xsl:text>")&#xA;</xsl:text>
        <xsl:text>    Emitter&lt;Record&lt;</xsl:text>
        <xsl:value-of select="./@key"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="./dto/@name"/>
        <xsl:text>Dto&gt;&gt; </xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./dto/@name"/>
        </xsl:call-template>
        <xsl:text>DtoEmitter;&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>

        <xsl:text>    public </xsl:text>
        <xsl:value-of select="./dto/@entity"/>
        <xsl:text> send</xsl:text>
        <xsl:value-of select="./dto/@name"/>
        <xsl:text>(final </xsl:text>
        <xsl:value-of select="./@key"/>
        <xsl:text> key, final </xsl:text>
        <xsl:value-of select="./dto/@entity"/>
        <xsl:text> payload) {&#xA;</xsl:text>
        <xsl:text>        </xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./dto/@name"/>
        </xsl:call-template>
        <xsl:text>DtoEmitter.send(Record.of(key, </xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./dto/@name"/>
        </xsl:call-template>
        <xsl:text>Mapper.</xsl:text>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="./dto/@entity"/>
        </xsl:call-template>
        <xsl:text>To</xsl:text>
        <xsl:value-of select="./dto/@name"/>
        <xsl:text>Dto(payload)));&#xA;</xsl:text>
        <xsl:text>        return payload;&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="consumer|producer">
        <xsl:variable name="base-package"
                      select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="kafka-package"
                      select="concat($base-package,'.kafka')"/>
        <xsl:variable name="dto-package-prefix"
                      select="concat($kafka-package,'.dto.')"/>
        <xsl:variable name="utils-package-prefix"
                      select="concat($kafka-package,'.utils.')"/>
        <xsl:variable name="service-package-prefix"
                      select="concat($base-package,'.service.')"/>

        <xsl:variable name="classname">
            <xsl:call-template name="firstUpper">
                <xsl:with-param name="text" select="./@topic"/>
            </xsl:call-template>
            <xsl:call-template name="firstUpper">
                <xsl:with-param name="text" select="name()"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="filename"
                      select="concat($OutputBaseDirectory,'/',translate($kafka-package,'.','/'),'/',$classname,'.java')"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$kafka-package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.fasterxml.jackson.databind.ObjectMapper;&#xA;</xsl:text>
            <xsl:text>import io.smallrye.reactive.messaging.kafka.KafkaRecord;&#xA;</xsl:text>
            <xsl:text>import io.smallrye.reactive.messaging.annotations.Blocking;&#xA;</xsl:text>
            <xsl:text>import org.eclipse.microprofile.reactive.messaging.Incoming;&#xA;</xsl:text>
            <xsl:text>import org.jboss.logging.Logger;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import javax.enterprise.context.ApplicationScoped;&#xA;</xsl:text>
            <xsl:text>import javax.inject.Inject;&#xA;</xsl:text>
            <xsl:text>import java.io.IOException;&#xA;</xsl:text>
            <xsl:text>import java.util.concurrent.CompletionStage;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:call-template name="imports">
                <xsl:with-param name="dto-package-prefix" select="$dto-package-prefix"/>
                <xsl:with-param name="utils-package-prefix" select="$utils-package-prefix"/>
                <xsl:with-param name="service-package-prefix" select="$service-package-prefix"/>
            </xsl:call-template>

            <xsl:text>@ApplicationScoped&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> {&#xA;</xsl:text>
            <xsl:text>    private static final Logger LOGGER = Logger.getLogger(</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>.class);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:call-template name="variables"/>
            <xsl:if test="name()='consumer'">
                <xsl:call-template name="consumer-method"/>
            </xsl:if>
            <xsl:if test="name()='producer'">
                <xsl:call-template name="producer-method"/>
            </xsl:if>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="topics">
        <xsl:apply-templates select="./consumer"/>
        <xsl:apply-templates select="./producer"/>
    </xsl:template>
</xsl:stylesheet>

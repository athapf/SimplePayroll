<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package" select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="path-parameter" mode="param">
        <xsl:text>final </xsl:text>
        <xsl:value-of select="./@java-type"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@name"/>
    </xsl:template>

    <xsl:template match="path-parameter" mode="variable">
        <xsl:if test="position() &gt; 1">, </xsl:if>
        <xsl:value-of select="./@name"/>
    </xsl:template>

    <xsl:template match="path-parameter" mode="path">
        <xsl:if test="../@path or position() &gt; 1">
            <xsl:text>/</xsl:text>
        </xsl:if>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="method">
        <xsl:text>    @</xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:if test="./@path or ./path-parameter">
            <xsl:text>    @Path("</xsl:text>
            <xsl:if test="./@path">
                <xsl:value-of select="./@path"/>
            </xsl:if>
            <xsl:apply-templates select="./path-parameter" mode="path"/>
            <xsl:text>")&#xA;</xsl:text>
        </xsl:if>
        <xsl:text>    public </xsl:text>
        <xsl:choose>
            <xsl:when test="./@result='list'">
                <xsl:text>List&lt;</xsl:text>
                <xsl:value-of select="../@entity"/>
                <xsl:text>&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="./@result='single'">
                <xsl:value-of select="../@entity"/>
            </xsl:when>
            <xsl:otherwise>void</xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(</xsl:text>
        <xsl:if test="./@type='POST' or ./@type='PUT'">
            <xsl:text>final </xsl:text>
            <xsl:value-of select="../@entity"/>
            <xsl:text> content</xsl:text>
            <xsl:if test="./path-parameter">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:if>
        <xsl:apply-templates select="./path-parameter" mode="param"/>
        <xsl:text>) {&#xA;</xsl:text>
        <xsl:text>        LOGGER.info("</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text> ...");&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>        </xsl:text>
        <xsl:if test="./@result = 'list' or ./@result = 'single'">return </xsl:if>
        <xsl:text>controller.</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(</xsl:text>
        <xsl:if test="./@type='POST' or ./@type='PUT'">
            <xsl:text>content</xsl:text>
            <xsl:if test="./path-parameter">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:if>
        <xsl:apply-templates select="./path-parameter" mode="variable"/>
        <xsl:text>);&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="resource">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/boundary/',./@name,'Resources.java')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.boundary;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.controller.</xsl:text>
            <xsl:value-of select="./@controller"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.entity.</xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import javax.enterprise.context.ApplicationScoped;&#xA;</xsl:text>
            <xsl:text>import javax.inject.Inject;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.Consumes;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.DELETE;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.GET;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.POST;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.PUT;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.Path;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.Produces;&#xA;</xsl:text>
            <xsl:text>import javax.ws.rs.core.MediaType;&#xA;</xsl:text>
            <xsl:text>import java.util.List;&#xA;</xsl:text>
            <xsl:text>import org.jboss.logging.Logger;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Path("/</xsl:text>
            <xsl:value-of select="./@path"/>
            <xsl:text>")&#xA;</xsl:text>
            <xsl:text>@Produces(MediaType.APPLICATION_JSON)&#xA;</xsl:text>
            <xsl:text>@Consumes(MediaType.APPLICATION_JSON)&#xA;</xsl:text>
            <xsl:text>@ApplicationScoped&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>Resources {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>private static final Logger LOGGER = Logger.getLogger("</xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>Resources");&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @Inject&#xA;</xsl:text>
            <xsl:text>    private </xsl:text>
            <xsl:value-of select="./@controller"/>
            <xsl:text> controller;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="./method"/>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="resources">
        <xsl:apply-templates select="./resource"/>
    </xsl:template>
</xsl:stylesheet>

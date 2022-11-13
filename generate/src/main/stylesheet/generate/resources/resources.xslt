<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="resource" mode="imports">
        <xsl:param name="dto-package-prefix"/>
        <xsl:param name="utils-package-prefix"/>
        <xsl:param name="service-package-prefix"/>

        <xsl:for-each select="./dto">
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$dto-package-prefix"/>
            <xsl:value-of select="./@name"/>
            <xsl:text>Dto;&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$utils-package-prefix"/>
            <xsl:value-of select="./@name"/>
            <xsl:text>Mapper;&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$service-package-prefix"/>
            <xsl:value-of select="./@entity"/>
            <xsl:text>;&#xA;</xsl:text>
        </xsl:for-each>
        <xsl:if test="./@service">
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$service-package-prefix"/>
            <xsl:value-of select="./@service"/>
            <xsl:text>;&#xA;</xsl:text>
        </xsl:if>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="resource" mode="variables">
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
        <xsl:for-each select="./dto">
            <xsl:text>    @Inject&#xA;</xsl:text>
            <xsl:text>    private </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>Mapper </xsl:text>
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@name"/>
            </xsl:call-template>
            <xsl:text>Mapper;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="param" mode="param">
        <xsl:text>final </xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@name"/>
    </xsl:template>

    <xsl:template match="param" mode="variable">
        <xsl:if test="position() &gt; 1">, </xsl:if>
        <xsl:value-of select="./@name"/>
    </xsl:template>

    <xsl:template match="param" mode="path">
        <xsl:if test="../@path or position() &gt; 1">
            <xsl:text>/</xsl:text>
        </xsl:if>
        <xsl:text>{</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="method">
        <xsl:variable name="dto-name" select="./@dto"/>
        <xsl:variable name="dto" select="concat($dto-name,'Dto')"/>
        <xsl:variable name="dto-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$dto"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="entity" select="../dto[./@name=$dto-name]/@entity"/>
        <xsl:variable name="entity-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:if test="position()&gt;1">
            <xsl:text>&#xA;</xsl:text>
        </xsl:if>
        <xsl:text>    @</xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text>&#xA;</xsl:text>
        <xsl:if test="./@path">
            <xsl:text>    @Path("</xsl:text>
            <xsl:if test="./@path">
                <xsl:value-of select="./@path"/>
            </xsl:if>
            <xsl:text>")&#xA;</xsl:text>
        </xsl:if>
        <xsl:if test="./@result='Multi'">
            <xsl:text>    @Produces(MediaType.SERVER_SENT_EVENTS)&#xA;</xsl:text>
        </xsl:if>
        <xsl:text>    public </xsl:text>
        <xsl:choose>
            <xsl:when test="./@result='list'">
                <xsl:text>List&lt;</xsl:text>
                <xsl:value-of select="$dto"/>
                <xsl:text>&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="./@result='single'">
                <xsl:value-of select="$dto"/>
            </xsl:when>
            <xsl:when test="./@result='Multi'">
                <xsl:text>Multi&lt;</xsl:text>
                <xsl:value-of select="$dto"/>
                <xsl:text>&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>void</xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(</xsl:text>
        <xsl:if test="./@type='POST' or ./@type='PUT'">
            <xsl:text>final </xsl:text>
            <xsl:value-of select="$dto"/>
            <xsl:text> content</xsl:text>
            <xsl:if test="./param">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:if>
        <xsl:apply-templates select="./param" mode="param"/>
        <xsl:text>) {&#xA;</xsl:text>
        <xsl:text>        LOGGER.info("</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text> ...");&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>        </xsl:text>
        <xsl:if test="./@result='list' or ./@result='single' or ./@result='Multi'">return </xsl:if>

        <xsl:if test="./@result='list' or ./@result='single'">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@dto"/>
            </xsl:call-template>
            <xsl:text>Mapper.</xsl:text>
            <xsl:value-of select="$entity-value"/>
            <xsl:if test="./@result='list'">
                <xsl:text>List</xsl:text>
            </xsl:if>
            <xsl:text>To</xsl:text>
            <xsl:value-of select="$dto"/>
            <xsl:if test="./@result='list'">
                <xsl:text>List</xsl:text>
            </xsl:if>
            <xsl:text>(</xsl:text>
        </xsl:if>
        <xsl:call-template name="firstLower">
            <xsl:with-param name="text" select="../@service"/>
        </xsl:call-template>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(</xsl:text>
        <xsl:if test="./@type='POST' or ./@type='PUT'">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@dto"/>
            </xsl:call-template>
            <xsl:text>Mapper.</xsl:text>
            <xsl:value-of select="$dto-value"/>
            <xsl:text>To</xsl:text>
            <xsl:value-of select="$entity"/>
            <xsl:text>(content)</xsl:text>
            <xsl:if test="./param">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:if>
        <xsl:apply-templates select="./param" mode="variable"/>
        <xsl:text>)</xsl:text>
        <xsl:if test="./@result='list' or ./@result='single'">
            <xsl:text>)</xsl:text>
        </xsl:if>

        <xsl:if test="./@result='Multi'">
            <xsl:text>.onItem().transform(&#xA;</xsl:text>
            <xsl:text>            item -&gt; </xsl:text>
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@dto"/>
            </xsl:call-template>
            <xsl:text>Mapper.</xsl:text>
            <xsl:variable name="dto" select="./@dto"/>
            <xsl:variable name="entity" select="../dto[./@name=$dto]/@entity"/>
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity"/>
            </xsl:call-template>
            <xsl:text>To</xsl:text>
            <xsl:value-of select="$dto"/>
            <xsl:text>Dto(item))</xsl:text>
        </xsl:if>
        <xsl:text>;&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="resource">
        <xsl:variable name="base-package"
                      select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="rest-package"
                      select="concat($base-package,'.rest')"/>
        <xsl:variable name="dto-package-prefix"
                      select="concat($rest-package,'.dto.')"/>
        <xsl:variable name="utils-package-prefix"
                      select="concat($rest-package,'.utils.')"/>
        <xsl:variable name="service-package-prefix"
                      select="concat($base-package,'.service.')"/>
        <xsl:variable name="classname" select="concat(./@name,'Resource')"/>
        <xsl:variable name="filename"
                      select="concat($OutputBaseDirectory,'/',translate($rest-package,'.','/'),'/',$classname,'.java')"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$rest-package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="." mode="imports">
                <xsl:with-param name="dto-package-prefix" select="$dto-package-prefix"/>
                <xsl:with-param name="utils-package-prefix" select="$utils-package-prefix"/>
                <xsl:with-param name="service-package-prefix" select="$service-package-prefix"/>
            </xsl:apply-templates>

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
            <xsl:text>import io.smallrye.mutiny.Multi;&#xA;</xsl:text>
            <xsl:text>import org.jboss.logging.Logger;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Path("/</xsl:text>
            <xsl:value-of select="./@path"/>
            <xsl:text>")&#xA;</xsl:text>
            <xsl:text>@Produces(MediaType.APPLICATION_JSON)&#xA;</xsl:text>
            <xsl:text>@Consumes(MediaType.APPLICATION_JSON)&#xA;</xsl:text>
            <xsl:text>@ApplicationScoped&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>private static final Logger LOGGER = Logger.getLogger(</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>.class);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="." mode="variables"/>
            <xsl:apply-templates select="./method"/>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="resources">
        <xsl:apply-templates select="./resource"/>
    </xsl:template>
</xsl:stylesheet>

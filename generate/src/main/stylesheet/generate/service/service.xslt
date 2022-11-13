<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="param" mode="inService">
        <xsl:text>final </xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@name"/>
    </xsl:template>

    <xsl:template match="consumer" mode="inService">
        <xsl:variable name="dto" select="./dto/@name"/>
        <xsl:variable name="entity" select="./dto/@entity"/>
        <xsl:text>    void </xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(final </xsl:text>
        <xsl:value-of select="./@key"/>
        <xsl:text> key, final </xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text> payload);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="method" mode="inService">
        <xsl:variable name="dto" select="./@dto"/>
        <xsl:variable name="entity" select="../dto[./@name=$dto]/@entity"/>
        <xsl:text>    </xsl:text>
        <xsl:choose>
            <xsl:when test="./@result='list'">
                <xsl:text>List&lt;</xsl:text>
                <xsl:value-of select="$entity"/>
                <xsl:text>&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="./@result='single'">
                <xsl:value-of select="$entity"/>
            </xsl:when>
            <xsl:when test="./@result='Multi'">
                <xsl:text>Multi&lt;</xsl:text>
                <xsl:value-of select="$entity"/>
                <xsl:text>&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>void</xsl:otherwise>
        </xsl:choose>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(</xsl:text>
        <xsl:if test="./@type='POST' or ./@type='PUT'">
            <xsl:text>final </xsl:text>
            <xsl:value-of select="$entity"/>
            <xsl:text> content</xsl:text>
            <xsl:if test="./path-parameter">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:if>
        <xsl:apply-templates select="./param" mode="inService"/>
        <xsl:text>);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="node()" mode="startService">
        <xsl:variable name="service" select="./@service"/>
        <xsl:variable name="base-package"
                      select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="package"
                      select="concat($base-package,'.service')"/>
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$KomponentPath,'/',translate(/komponent/@name,$upper,$lower),'/service/',$service,'.java')"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import io.smallrye.mutiny.Multi;&#xA;</xsl:text>
            <xsl:text>import java.util.List;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>public interface </xsl:text>
            <xsl:value-of select="$service"/>
            <xsl:text> {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="/komponent/descendant::method[../@service=$service]" mode="inService"/>
            <xsl:apply-templates select="/komponent/descendant::consumer[./@service=$service]" mode="inService"/>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="node()" mode="service">
        <xsl:variable name="service" select="./@service"/>
        <xsl:if test="count(./preceding::node()[./@service=$service])&lt;1">
            <xsl:apply-templates select="." mode="startService"/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>

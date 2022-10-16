<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package" select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="path-parameter" mode="controller">
        <xsl:text>final </xsl:text>
        <xsl:value-of select="./@java-type"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@name"/>
    </xsl:template>

    <xsl:template match="method" mode="controller">
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
        <xsl:apply-templates select="./path-parameter" mode="controller"/>
        <xsl:text>);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="resource" mode="controller">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/controller/',./@controller,'.java')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.controller;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.entity.</xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import java.util.List;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>public interface </xsl:text>
            <xsl:value-of select="./@controller"/>
            <xsl:text> {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="./method" mode="controller"/>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

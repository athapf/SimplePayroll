<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:template match="field" mode="cassandra">
        <xsl:if test="position()>1">, </xsl:if>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text> </xsl:text>
        <xsl:choose>
            <xsl:when test="./@type='String'">text</xsl:when>
            <xsl:when test="./@type='BigDecimal'">decimal</xsl:when>
            <xsl:when test="./@type='Date'">date</xsl:when>
            <xsl:otherwise>text</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="./@key">
            <xsl:text> PRIMARY KEY</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="entity" mode="cassandra">
        <xsl:text>CREATE TABLE IF NOT EXISTS </xsl:text>
        <xsl:value-of select="translate(../../@name,$upper,$lower)"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text>(</xsl:text>
        <xsl:apply-templates select="./field" mode="cassandra"/>
        <xsl:text>);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="datacatalog" mode="cassandra">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/../cassandra/',translate(../@name,$upper,$lower),'.cql')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>CREATE KEYSPACE IF NOT EXISTS </xsl:text>
            <xsl:value-of select="translate(../@name,$upper,$lower)"/>
            <xsl:text> WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};&#xA;</xsl:text>
            <xsl:apply-templates select="entity" mode="cassandra"/>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

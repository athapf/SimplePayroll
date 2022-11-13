<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:template name="firstUpper">
        <xsl:param name="text"/>
        <xsl:value-of select="concat(translate(substring($text,1,1),$lower,$upper),substring($text,2))"/>
    </xsl:template>

    <xsl:template name="firstLower">
        <xsl:param name="text"/>
        <xsl:value-of select="concat(translate(substring($text,1,1),$upper,$lower),substring($text,2))"/>
    </xsl:template>

    <xsl:template name="allUpper">
        <xsl:param name="text"/>
        <xsl:value-of select="translate($text,$lower,$upper)"/>
    </xsl:template>

    <xsl:template name="allLower">
        <xsl:param name="text"/>
        <xsl:value-of select="translate($text,$upper,$lower)"/>
    </xsl:template>
</xsl:stylesheet>

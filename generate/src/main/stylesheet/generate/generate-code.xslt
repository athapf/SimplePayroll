<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="utils/text.xslt"/>
    <xsl:import href="komponent.xslt"/>

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:param name="Exclude"/>

    <xsl:template match="/">
        <xsl:if test="not($Exclude='all')">
            <xsl:apply-templates select="/komponent"/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>

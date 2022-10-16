<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="dao.xslt"/>
    <xsl:import href="mapper.xslt"/>

    <xsl:template match="database[./dao/@target='cassandra']">
        <xsl:apply-templates select="./dao[./@target='cassandra']" mode="dao"/>
        <xsl:apply-templates select="./dao[./@target='cassandra']" mode="mapper"/>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="resources.xslt"/>
    <xsl:import href="controller.xslt"/>
    <xsl:import href="topics/topics.xslt"/>
    <xsl:import href="entity.xslt"/>
    <xsl:import href="cassandra/cassandra.xslt"/>
    <xsl:import href="cassandra/initdb.xslt"/>

    <xsl:template match="komponent">
        <xsl:apply-templates select="./resources"/>
        <xsl:apply-templates select="./topics"/>
        <xsl:apply-templates select="./resources/resource" mode="controller"/>
        <xsl:apply-templates select="./datacatalog/entity"/>
        <xsl:apply-templates select="./database"/>
        <xsl:apply-templates select="./datacatalog" mode="cassandra"/>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="./data/data.xslt"/>
    <xsl:import href="./data/mapper.xslt"/>
    <xsl:import href="./resources/resources.xslt"/>
    <xsl:import href="./kafka/topic.xslt"/>
    <xsl:import href="./service/service.xslt"/>
    <xsl:import href="./cassandra/worker.xslt"/>
    <xsl:import href="./cassandra/mapper.xslt"/>
    <xsl:import href="./cassandra/dao.xslt"/>
    <xsl:import href="./cassandra/initdb.xslt"/>

    <xsl:template match="komponent">
        <xsl:apply-templates select="./descendant::dto"/>
        <xsl:apply-templates select="./descendant::dto" mode="mapper"/>
        <xsl:apply-templates select="./descendant::database/dao" mode="mapper"/>
        <xsl:apply-templates select="./descendant::dao/entity" mode="dao"/>
        <xsl:apply-templates select="./descendant::datacatalog/entity" mode="value"/>
        <xsl:apply-templates select="./descendant::consumer"/>
        <xsl:apply-templates select="./descendant::producer"/>
        <xsl:apply-templates select="./descendant::resources"/>
        <xsl:apply-templates select="./descendant::node()[./@service]" mode="service"/>
        <xsl:apply-templates select="./descendant::database/dao" mode="worker"/>
        <xsl:apply-templates select="./descendant::database/dao" mode="dao-mapper"/>
        <xsl:apply-templates select="./descendant::database/dao" mode="dao"/>
        <xsl:apply-templates select="./descendant::database" mode="cassandra"/>
    </xsl:template>
</xsl:stylesheet>

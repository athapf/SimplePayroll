<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="dao" mode="liquibase-tables">
        <xsl:variable name="table" select="./@name"/>
        <xsl:variable name="name">
            <xsl:call-template name="allLower">
                <xsl:with-param name="text" select="./@name"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/../res/liquibase/v1.0/00',position(),'_',$name,'.cql')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>-- liquibase formatted sql&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>-- changeset liquibase</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:text>:&#xA;</xsl:text>
            <xsl:apply-templates select="./entity" mode="cassandra"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="database" mode="liquibase-init">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/../res/liquibase/init/001_keyspace.cql')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>-- liquibase formatted sql&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>-- changeset liquibase:1&#xA;</xsl:text>
            <xsl:text>CREATE KEYSPACE IF NOT EXISTS </xsl:text>
            <xsl:value-of select="./@keyspace"/>
            <xsl:text> WITH replication = {'class':'SimpleStrategy', 'replication_factor':1};&#xA;</xsl:text>
        </xsl:result-document>
        <xsl:apply-templates select="./dao" mode="liquibase-tables"/>
        <xsl:variable name="filename2" select="concat($OutputBaseDirectory,'/../res/liquibase/dbchangelog.xml')"/>
        <xsl:result-document href="{$filename2}">
            <xsl:text>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&#xA;</xsl:text>
            <xsl:text>&lt;databaseChangeLog&#xA;</xsl:text>
            <xsl:text>        xmlns="http://www.liquibase.org/xml/ns/dbchangelog"&#xA;</xsl:text>
            <xsl:text>        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&#xA;</xsl:text>
            <xsl:text>        xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext"&#xA;</xsl:text>
            <xsl:text>        xmlns:pro="http://www.liquibase.org/xml/ns/pro"&#xA;</xsl:text>
            <xsl:text>        xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog&#xA;</xsl:text>
            <xsl:text>http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd&#xA;</xsl:text>
            <xsl:text>http://www.liquibase.org/xml/ns/dbchangelog-ext http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-ext.xsd&#xA;</xsl:text>
            <xsl:text>http://www.liquibase.org/xml/ns/pro http://www.liquibase.org/xml/ns/pro/liquibase-pro-latest.xsd"&gt;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    &lt;includeAll path="./v1.0" relativeToChangelogFile="true"/&gt;&#xA;</xsl:text>
            <xsl:text>&lt;/databaseChangeLog&gt;&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

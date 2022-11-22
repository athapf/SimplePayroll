<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="komponent" mode="properties">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/../res/application.properties')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>%prod.kafka.bootstrap.servers=kafka:9092&#xA;</xsl:text>
            <xsl:text>%dev.kafka.bootstrap.servers=localhost:9092&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>quarkus.cassandra.contact-points=database:9042&#xA;</xsl:text>
            <xsl:text>quarkus.cassandra.local-datacenter=datacenter1&#xA;</xsl:text>
            <xsl:text>quarkus.cassandra.keyspace=</xsl:text>
            <xsl:value-of select="./database/@keyspace"/>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>quarkus.cassandra.auth.username=cassandra&#xA;</xsl:text>
            <xsl:text>quarkus.cassandra.auth.password=cassandra&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>quarkus.liquibase.schemas=DEFAULT_TEST_SCHEMA&#xA;</xsl:text>
            <xsl:text>quarkus.liquibase.change-log=db/changeLog.xml&#xA;</xsl:text>
            <xsl:text>quarkus.liquibase.migrate-at-start=true&#xA;</xsl:text>
            <xsl:for-each select="./topics/producer">
                <xsl:text>&#xA;</xsl:text>
                <xsl:text>mp.messaging.outgoing.</xsl:text>
                <xsl:value-of select="./@topic"/>
                <xsl:text>.topic=</xsl:text>
                <xsl:value-of select="./@topic"/>
                <xsl:text>&#xA;</xsl:text>
                <xsl:text>mp.messaging.outgoing.</xsl:text>
                <xsl:value-of select="./@topic"/>
                <xsl:text>.connector=smallrye-kafka&#xA;</xsl:text>
            </xsl:for-each>
            <xsl:for-each select="./topics/consumer">
                <xsl:text>&#xA;</xsl:text>
                <xsl:text>mp.messaging.incomming.</xsl:text>
                <xsl:value-of select="./@topic"/>
                <xsl:text>.topic=</xsl:text>
                <xsl:value-of select="./@topic"/>
                <xsl:text>&#xA;</xsl:text>
                <xsl:text>mp.messaging.incomming.</xsl:text>
                <xsl:value-of select="./@topic"/>
                <xsl:text>.connector=smallrye-kafka&#xA;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

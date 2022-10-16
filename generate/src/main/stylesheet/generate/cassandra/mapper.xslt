<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package" select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="dao[./@target='cassandra']" mode="mapper">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/boundary/',./@entity,'Mapper.java')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.boundary;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.DaoFactory;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Mapper;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Mapper&#xA;</xsl:text>
            <xsl:text>public interface </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>Mapper {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @DaoFactory&#xA;</xsl:text>
            <xsl:text>    </xsl:text>
            <xsl:value-of select="./@entity"/>
            <xsl:text>Dao </xsl:text>
            <xsl:value-of select="translate(./@entity,$upper,$lower)"/>
            <xsl:text>Dao();&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

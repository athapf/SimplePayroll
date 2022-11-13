<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="dao[./@target='cassandra']" mode="dao-mapper">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$KomponentPath,'/',translate(/komponent/@name,$upper,$lower),'/data/cassandra/',./@name,'DaoMapper.java')"/>
        <xsl:variable name="base-package"
                      select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="db-package"
                      select="concat($base-package,'.data.cassandra')"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$db-package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.DaoFactory;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Mapper;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Mapper&#xA;</xsl:text>
            <xsl:text>public interface </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>DaoMapper {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @DaoFactory&#xA;</xsl:text>
            <xsl:text>    </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>Worker </xsl:text>
            <xsl:value-of select="translate(./@name,$upper,$lower)"/>
            <xsl:text>Worker();&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

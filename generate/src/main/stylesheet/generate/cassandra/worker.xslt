<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="insert">
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  @Insert&#xA;</xsl:text>
        <xsl:text>  void insert</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Entity value);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="update">
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  @Update&#xA;</xsl:text>
        <xsl:text>  void update</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Entity value);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="delete">
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  @Delete&#xA;</xsl:text>
        <xsl:text>  void delete</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Entity value);&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  @Delete(entityClass = </xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Entity.class)&#xA;</xsl:text>
        <xsl:text>  void delete</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>(</xsl:text>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="field" select="../../../datacatalog/entity[./@name=$data]/field[./@key='true']"/>
        <xsl:value-of select="$field/@type"/>
        <xsl:text> key);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="findByKey">
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  @Select&#xA;</xsl:text>
        <xsl:text>  </xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Entity find</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>ById(</xsl:text>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="field" select="../../../datacatalog/entity[./@name=$data]/field[./@key='true']"/>
        <xsl:value-of select="$field/@type"/>
        <xsl:text> key);&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="findAll">
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  @Select&#xA;</xsl:text>
        <xsl:text>  </xsl:text>
        <xsl:choose>
            <xsl:when test="./@result='paging'">
                <xsl:text>PagingIterable</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>List</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>Entity&gt; findAll</xsl:text>
        <xsl:value-of select="./@entity"/>
        <xsl:text>();&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="insert">
        <xsl:call-template name="insert"/>
    </xsl:template>

    <xsl:template match="update">
        <xsl:call-template name="update"/>
    </xsl:template>

    <xsl:template match="delete">
        <xsl:call-template name="delete"/>
    </xsl:template>

    <xsl:template match="findall">
        <xsl:call-template name="findAll"/>
    </xsl:template>

    <xsl:template match="select">
    </xsl:template>

    <xsl:template match="crud">
        <xsl:call-template name="insert"/>
        <xsl:call-template name="update"/>
        <xsl:call-template name="delete"/>
        <xsl:call-template name="findByKey"/>
        <xsl:call-template name="findAll"/>
    </xsl:template>

    <xsl:template match="dao" mode="worker">
        <xsl:variable name="base-package"
                      select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="db-package"
                      select="concat($base-package,'.data')"/>
        <xsl:variable name="entity-package-prefix"
                      select="concat($db-package,'.cassandra.')"/>
        <xsl:variable name="utils-package-prefix"
                      select="concat($db-package,'.utils.')"/>

        <xsl:variable name="classname">
            <xsl:call-template name="firstUpper">
                <xsl:with-param name="text" select="./@name"/>
            </xsl:call-template>
            <xsl:text>Worker</xsl:text>
        </xsl:variable>

        <xsl:variable name="filename"
                      select="concat($OutputBaseDirectory,'/',translate($db-package,'.','/'),'/cassandra/',$classname,'.java')"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$db-package"/>
            <xsl:text>.cassandra;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.core.PagingIterable;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Dao;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Delete;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Select;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Update;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Insert;&#xA;</xsl:text>
            <xsl:text>import java.util.List;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Dao&#xA;</xsl:text>
            <xsl:text>public interface </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> {&#xA;</xsl:text>
            <xsl:apply-templates select="crud"/>
            <xsl:apply-templates select="insert"/>
            <xsl:apply-templates select="update"/>
            <xsl:apply-templates select="delete"/>
            <xsl:apply-templates select="findall"/>
            <xsl:apply-templates select="select"/>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

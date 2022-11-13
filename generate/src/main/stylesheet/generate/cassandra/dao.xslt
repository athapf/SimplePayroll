<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="insert-dao">
        <xsl:variable name="mapper">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@entity"/>
            </xsl:call-template>
            <xsl:text>Mapper</xsl:text>
        </xsl:variable>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="entity-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="data-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$data"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  public void insert</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(final </xsl:text>
        <xsl:value-of select="$data"/>
        <xsl:text> value) {&#xA;</xsl:text>
        <xsl:text>    worker.insert</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="$mapper"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$data-value"/>
        <xsl:text>To</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>Entity(value));&#xA;</xsl:text>
        <xsl:text>  }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="update-dao">
        <xsl:variable name="mapper">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@entity"/>
            </xsl:call-template>
            <xsl:text>Mapper</xsl:text>
        </xsl:variable>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="entity-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="data-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$data"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  public void update</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(final </xsl:text>
        <xsl:value-of select="$data"/>
        <xsl:text> value) {&#xA;</xsl:text>
        <xsl:text>    worker.update</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="$mapper"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$data-value"/>
        <xsl:text>To</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>Entity(value));&#xA;</xsl:text>
        <xsl:text>  }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="delete-dao">
        <xsl:variable name="mapper">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@entity"/>
            </xsl:call-template>
            <xsl:text>Mapper</xsl:text>
        </xsl:variable>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="entity-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="data-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$data"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  public void delete</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(final </xsl:text>
        <xsl:value-of select="$data"/>
        <xsl:text> value) {&#xA;</xsl:text>
        <xsl:text>    worker.delete</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="$mapper"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$data-value"/>
        <xsl:text>To</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>Entity(value));&#xA;</xsl:text>
        <xsl:text>  }&#xA;</xsl:text>

        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  public void delete</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(final </xsl:text>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="field" select="../../../datacatalog/entity[./@name=$data]/field[./@key='true']"/>
        <xsl:value-of select="$field/@type"/>
        <xsl:text> key) {&#xA;</xsl:text>
        <xsl:text>    worker.delete</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>(key);&#xA;</xsl:text>
        <xsl:text>  }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="findByKey-dao">
        <xsl:variable name="mapper">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@entity"/>
            </xsl:call-template>
            <xsl:text>Mapper</xsl:text>
        </xsl:variable>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="entity-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="data-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$data"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  public </xsl:text>
        <xsl:value-of select="$data"/>
        <xsl:text> find</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>ById(final </xsl:text>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="field" select="../../../datacatalog/entity[./@name=$data]/field[./@key='true']"/>
        <xsl:value-of select="$field/@type"/>
        <xsl:text> key) {&#xA;</xsl:text>
        <xsl:text>    return </xsl:text>
        <xsl:value-of select="$mapper"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$entity-value"/>
        <xsl:text>EntityTo</xsl:text>
        <xsl:value-of select="$data"/>
        <xsl:text>(worker.find</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>ById(key));&#xA;</xsl:text>
        <xsl:text>  }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="findAll-dao">
        <xsl:variable name="mapper">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="./@entity"/>
            </xsl:call-template>
            <xsl:text>Mapper</xsl:text>
        </xsl:variable>
        <xsl:variable name="entity" select="./@entity"/>
        <xsl:variable name="entity-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="data" select="../entity[./@name=$entity]/@data"/>
        <xsl:variable name="data-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$data"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  public </xsl:text>
        <xsl:choose>
            <xsl:when test="./@result='paging'">
                <xsl:text>PagingIterable</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>List</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="$data"/>
        <xsl:text>&gt; findAll</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>() {&#xA;</xsl:text>
        <xsl:text>    return </xsl:text>
        <xsl:value-of select="$mapper"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$entity-value"/>
        <xsl:text>EntityListTo</xsl:text>
        <xsl:value-of select="$data"/>
        <xsl:text>List(worker.findAll</xsl:text>
        <xsl:value-of select="$entity"/>
        <xsl:text>());&#xA;</xsl:text>
        <xsl:text>  }&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="insert" mode="dao">
        <xsl:call-template name="insert-dao"/>
    </xsl:template>

    <xsl:template match="update" mode="dao">
        <xsl:call-template name="update-dao"/>
    </xsl:template>

    <xsl:template match="delete" mode="dao">
        <xsl:call-template name="delete-dao"/>
    </xsl:template>

    <xsl:template match="findall" mode="dao">
        <xsl:call-template name="findAll-dao"/>
    </xsl:template>

    <xsl:template match="select" mode="dao">
    </xsl:template>

    <xsl:template match="crud" mode="dao">
        <xsl:call-template name="insert-dao"/>
        <xsl:call-template name="update-dao"/>
        <xsl:call-template name="delete-dao"/>
        <xsl:call-template name="findByKey-dao"/>
        <xsl:call-template name="findAll-dao"/>
    </xsl:template>

    <xsl:template match="dao" mode="dao">
        <xsl:variable name="base-package"
                      select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="db-package"
                      select="concat($base-package,'.data')"/>

        <xsl:variable name="classname">
            <xsl:call-template name="firstUpper">
                <xsl:with-param name="text" select="./@name"/>
            </xsl:call-template>
            <xsl:text>Dao</xsl:text>
        </xsl:variable>

        <xsl:variable name="filename"
                      select="concat($OutputBaseDirectory,'/',translate($db-package,'.','/'),'/',$classname,'.java')"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$db-package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="$db-package"/>
            <xsl:text>.cassandra.</xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>Worker;&#xA;</xsl:text>
            <xsl:for-each select="./entity">
                <xsl:text>import </xsl:text>
                <xsl:value-of select="$db-package"/>
                <xsl:text>.utils.</xsl:text>
                <xsl:value-of select="./@name"/>
                <xsl:text>Mapper;&#xA;</xsl:text>
                <xsl:text>import </xsl:text>
                <xsl:value-of select="$base-package"/>
                <xsl:text>.service.</xsl:text>
                <xsl:value-of select="./@data"/>
                <xsl:text>;&#xA;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.core.PagingIterable;&#xA;</xsl:text>
            <xsl:text>import javax.enterprise.context.ApplicationScoped;&#xA;</xsl:text>
            <xsl:text>import javax.inject.Inject;&#xA;</xsl:text>
            <xsl:text>import java.util.List;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@ApplicationScoped&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Inject&#xA;</xsl:text>
            <xsl:text>private </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>Worker worker;&#xA;</xsl:text>
            <xsl:for-each select="./entity">
                <xsl:text>&#xA;</xsl:text>
                <xsl:text>@Inject&#xA;</xsl:text>
                <xsl:text>private </xsl:text>
                <xsl:value-of select="./@name"/>
                <xsl:text>Mapper </xsl:text>
                <xsl:call-template name="firstLower">
                    <xsl:with-param name="text" select="./@name"/>
                </xsl:call-template>
                <xsl:text>Mapper;&#xA;</xsl:text>
            </xsl:for-each>
            <xsl:apply-templates select="crud" mode="dao"/>
            <xsl:apply-templates select="insert" mode="dao"/>
            <xsl:apply-templates select="update" mode="dao"/>
            <xsl:apply-templates select="delete" mode="dao"/>
            <xsl:apply-templates select="findall" mode="dao"/>
            <xsl:apply-templates select="select" mode="dao"/>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

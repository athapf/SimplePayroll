<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="entity" mode="mapper">
        <xsl:variable name="subpackage" select="'data.utils'"/>
        <xsl:variable name="subpackage-target" select="'data.cassandra'"/>
        <xsl:variable name="data-name" select="./@data"/>
        <xsl:variable name="pre-package" select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="package" select="concat($pre-package,'.',$subpackage)"/>
        <xsl:variable name="classname" select="concat(./@name,'Entity')"/>
        <xsl:variable name="model-name" select="./@name"/>
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',translate($package,'.','/'),'/',$model-name,'Mapper.java')"/>
        <xsl:variable name="classname-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$classname"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="model-name-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$data-name"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="concat($pre-package,'.',$subpackage-target,'.',$classname)"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="concat($pre-package,'.service.',$data-name)"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>import org.mapstruct.Builder;&#xA;</xsl:text>
            <xsl:text>import org.mapstruct.Mapper;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import java.util.List;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Mapper(componentModel = "cdi", builder = @Builder(disableBuilder = true))&#xA;</xsl:text>
            <xsl:text>public interface </xsl:text>
            <xsl:value-of select="$model-name"/>
            <xsl:text>Mapper {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$model-name-value"/>
            <xsl:text>To</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>(</xsl:text>
            <xsl:value-of select="$data-name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$model-name-value"/>
            <xsl:text>);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    </xsl:text>
            <xsl:value-of select="$data-name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>To</xsl:text>
            <xsl:value-of select="$data-name"/>
            <xsl:text>(</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    List&lt;</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$model-name-value"/>
            <xsl:text>ListTo</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>List(List&lt;</xsl:text>
            <xsl:value-of select="$data-name"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$model-name-value"/>
            <xsl:text>List);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    List&lt;</xsl:text>
            <xsl:value-of select="$data-name"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>ListTo</xsl:text>
            <xsl:value-of select="$data-name"/>
            <xsl:text>List(List&lt;</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>List);&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="dto" mode="mapper">
        <xsl:variable name="subpackage">
            <xsl:choose>
                <xsl:when test="../name()='resource'">rest.utils</xsl:when>
                <xsl:when test="../name()='producer'">kafka.utils</xsl:when>
                <xsl:when test="../name()='consumer'">kafka.utils</xsl:when>
                <xsl:otherwise>utils</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="subpackage-target">
            <xsl:choose>
                <xsl:when test="../name()='resource'">rest.dto</xsl:when>
                <xsl:when test="../name()='producer'">kafka.dto</xsl:when>
                <xsl:when test="../name()='consumer'">kafka.dto</xsl:when>
                <xsl:otherwise>utils</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="entity-name" select="./@entity"/>
        <xsl:variable name="pre-package" select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>
        <xsl:variable name="package" select="concat($pre-package,'.',$subpackage)"/>
        <xsl:variable name="classname" select="concat(./@name,'Dto')"/>
        <xsl:variable name="model-name" select="./@name"/>
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',translate($package,'.','/'),'/',$model-name,'Mapper.java')"/>
        <xsl:variable name="classname-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$classname"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="entity-name-value">
            <xsl:call-template name="firstLower">
                <xsl:with-param name="text" select="$entity-name"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="concat($pre-package,'.',$subpackage-target,'.',$classname)"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>import </xsl:text>
            <xsl:value-of select="concat($pre-package,'.service.',$entity-name)"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>import org.mapstruct.Builder;&#xA;</xsl:text>
            <xsl:text>import org.mapstruct.Mapper;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import java.util.List;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Mapper(componentModel = "cdi", builder = @Builder(disableBuilder = true))&#xA;</xsl:text>
            <xsl:text>public interface </xsl:text>
            <xsl:value-of select="$model-name"/>
            <xsl:text>Mapper {&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$entity-name-value"/>
            <xsl:text>To</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>(</xsl:text>
            <xsl:value-of select="$entity-name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$entity-name-value"/>
            <xsl:text>);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    </xsl:text>
            <xsl:value-of select="$entity-name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>To</xsl:text>
            <xsl:value-of select="$entity-name"/>
            <xsl:text>(</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    List&lt;</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$entity-name-value"/>
            <xsl:text>ListTo</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>List(List&lt;</xsl:text>
            <xsl:value-of select="$entity-name"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$entity-name-value"/>
            <xsl:text>List);&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    List&lt;</xsl:text>
            <xsl:value-of select="$entity-name"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>ListTo</xsl:text>
            <xsl:value-of select="$entity-name"/>
            <xsl:text>List(List&lt;</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="$classname-value"/>
            <xsl:text>List);&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

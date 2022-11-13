<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="KomponentPath"/>

    <xsl:include href="../utils/text.xslt"/>

    <xsl:template match="field" mode="variable">
        <xsl:param name="indent"></xsl:param>
        <xsl:param name="kind"/>
        <xsl:if test="$kind='entity' and ./@key='true'">
            <xsl:value-of select="$indent"/>
            <xsl:text>@PartitionKey&#xA;</xsl:text>
        </xsl:if>
        <xsl:value-of select="$indent"/>
        <xsl:text>    private </xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text>;&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="field" mode="param">
        <xsl:if test="position()&gt;1">
            <xsl:text>,</xsl:text>
        </xsl:if>
        <xsl:text>&#xA;            final </xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
    </xsl:template>

    <xsl:template match="field" mode="assign">
        <xsl:text>        this.</xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text> = </xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text>;&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="field" mode="to-string">
        <xsl:text>            "</xsl:text>
        <xsl:if test="position()&gt;1">
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text>='" + </xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text> + '\'' +&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="field" mode="setter-getter">
        <xsl:text>    public </xsl:text>
        <xsl:value-of select="./@type"/> get<xsl:value-of select="./@name"/>
        <xsl:text>() {&#xA;</xsl:text>
        <xsl:text>        return </xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text>;&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
        <xsl:text>    public void set</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(final </xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text> value) {&#xA;</xsl:text>
        <xsl:text>        this.</xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text> = value;&#xA;</xsl:text>
        <xsl:text>    }&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="field" mode="with">
        <xsl:text>        public Builder with</xsl:text>
        <xsl:value-of select="./@name"/>
        <xsl:text>(final </xsl:text>
        <xsl:value-of select="./@type"/>
        <xsl:text> value) {&#xA;</xsl:text>
        <xsl:text>            this.</xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text> = value;&#xA;</xsl:text>
        <xsl:text>            return this;&#xA;</xsl:text>
        <xsl:text>        }&#xA;</xsl:text>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="field" mode="build">
        <xsl:text>            result.</xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text> = </xsl:text>
        <xsl:value-of select="translate(./@name,$upper,$lower)"/>
        <xsl:text>;&#xA;</xsl:text>
    </xsl:template>

    <xsl:template name="data">
        <xsl:param name="filename"/>
        <xsl:param name="package"/>
        <xsl:param name="classname"/>
        <xsl:param name="fields"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import java.math.BigDecimal;&#xA;</xsl:text>
            <xsl:text>import java.util.Date;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>{&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="variable"/>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>() {}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>(</xsl:text>
            <xsl:apply-templates select="$fields" mode="param"/>
            <xsl:text>) {&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="assign"/>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @Override&#xA;</xsl:text>
            <xsl:text>    public String toString() {&#xA;</xsl:text>
            <xsl:text>        return "</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>{" +&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="to-string"/>
            <xsl:text>            '}';&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="setter-getter"/>
            <xsl:text>    public static Builder builder() {&#xA;</xsl:text>
            <xsl:text>        return new Builder();&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public static class Builder {&#xA;</xsl:text>
            <xsl:text>        private Builder() {}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="variable">
                <xsl:with-param name="indent" select="'    '"/>
            </xsl:apply-templates>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="with"/>
            <xsl:text>        public </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> build() {&#xA;</xsl:text>
            <xsl:text>            final </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> result = new </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>();&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="build"/>
            <xsl:text>            return result;&#xA;</xsl:text>
            <xsl:text>        }&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="data-entity">
        <xsl:param name="filename"/>
        <xsl:param name="package"/>
        <xsl:param name="classname"/>
        <xsl:param name="table"/>
        <xsl:param name="fields"/>

        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Entity;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.NamingStrategy;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.CqlName;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.PartitionKey;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.entity.naming.NamingConvention;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import java.math.BigDecimal;&#xA;</xsl:text>
            <xsl:text>import java.util.Date;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Entity(defaultKeyspace = "</xsl:text>
            <xsl:value-of select="../../@keyspace"/>
            <xsl:text>")&#xA;</xsl:text>
            <xsl:text>//@NamingStrategy(convention = NamingConvention.UPPER_CASE)&#xA;</xsl:text>
            <xsl:text>@CqlName("</xsl:text>
            <xsl:value-of select="$table"/>
            <xsl:text>")&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>{&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="variable">
                <xsl:with-param name="kind">entity</xsl:with-param>
            </xsl:apply-templates>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>() {}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>(</xsl:text>
            <xsl:apply-templates select="$fields" mode="param"/>
            <xsl:text>) {&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="assign"/>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    @Override&#xA;</xsl:text>
            <xsl:text>    public String toString() {&#xA;</xsl:text>
            <xsl:text>        return "</xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>{" +&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="to-string"/>
            <xsl:text>            '}';&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="setter-getter"/>
            <xsl:text>    public static Builder builder() {&#xA;</xsl:text>
            <xsl:text>        return new Builder();&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public static class Builder {&#xA;</xsl:text>
            <xsl:text>        private Builder() {}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="variable">
                <xsl:with-param name="indent" select="'    '"/>
            </xsl:apply-templates>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="with"/>
            <xsl:text>        public </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> build() {&#xA;</xsl:text>
            <xsl:text>            final </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text> result = new </xsl:text>
            <xsl:value-of select="$classname"/>
            <xsl:text>();&#xA;</xsl:text>
            <xsl:apply-templates select="$fields" mode="build"/>
            <xsl:text>            return result;&#xA;</xsl:text>
            <xsl:text>        }&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="dto">
        <xsl:variable name="subpackage">
            <xsl:choose>
                <xsl:when test="../name()='resource'">rest.dto</xsl:when>
                <xsl:when test="../name()='producer'">kafka.dto</xsl:when>
                <xsl:when test="../name()='consumer'">kafka.dto</xsl:when>
                <xsl:otherwise>dto</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="entity-name" select="./@entity"/>
        <xsl:variable name="package" select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower),'.',$subpackage)"/>
        <xsl:variable name="classname" select="concat(./@name,'Dto')"/>
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',translate($package,'.','/'),'/',$classname,'.java')"/>
        <xsl:variable name="fields" select="/komponent/datacatalog/entity[./@name=$entity-name]/field"/>

        <xsl:call-template name="data">
            <xsl:with-param name="package" select="$package"/>
            <xsl:with-param name="classname" select="$classname"/>
            <xsl:with-param name="filename" select="$filename"/>
            <xsl:with-param name="fields" select="$fields"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="entity" mode="dao">
        <xsl:variable name="subpackage" select="concat('data.',../@target)"/>
        <xsl:variable name="data-name" select="./@data"/>
        <xsl:variable name="package" select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower),'.',$subpackage)"/>
        <xsl:variable name="classname" select="concat(./@name,'Entity')"/>
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',translate($package,'.','/'),'/',$classname,'.java')"/>
        <xsl:variable name="fields" select="/komponent/datacatalog/entity[./@name=$data-name]/field"/>

        <xsl:call-template name="data-entity">
            <xsl:with-param name="package" select="$package"/>
            <xsl:with-param name="classname" select="$classname"/>
            <xsl:with-param name="table">
                <xsl:call-template name="allUpper">
                    <xsl:with-param name="text" select="./@name"/>
                </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="filename" select="$filename"/>
            <xsl:with-param name="fields" select="$fields"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="entity" mode="value">
        <xsl:variable name="package" select="concat(translate($KomponentPath,'/','.'),'.',translate(/komponent/@name,$upper,$lower),'.service')"/>
        <xsl:variable name="classname" select="./@name"/>
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',translate($package,'.','/'),'/',$classname,'.java')"/>
        <xsl:variable name="fields" select="./field"/>

        <xsl:call-template name="data">
            <xsl:with-param name="package" select="$package"/>
            <xsl:with-param name="classname" select="$classname"/>
            <xsl:with-param name="filename" select="$filename"/>
            <xsl:with-param name="fields" select="$fields"/>
        </xsl:call-template>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="OutputBaseDirectory"/>
    <xsl:param name="PackagePath"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:variable name="package" select="concat(translate($PackagePath,'/','.'),'.',translate(/komponent/@name,$upper,$lower))"/>

    <xsl:template match="field" mode="variable">
        <xsl:if test="./@key">
            <xsl:text>    @PartitionKey&#xA;</xsl:text>
        </xsl:if>
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
        <xsl:text>            return this;</xsl:text>
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

    <xsl:template match="entity">
        <xsl:variable name="filename" select="concat($OutputBaseDirectory,'/',$PackagePath,'/',translate(/komponent/@name,$upper,$lower),'/entity/',./@name,'.java')"/>
        <xsl:result-document href="{$filename}">
            <xsl:text>package </xsl:text>
            <xsl:value-of select="$package"/>
            <xsl:text>.entity;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.Entity;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.PartitionKey;&#xA;</xsl:text>
            <xsl:text>import com.datastax.oss.driver.api.mapper.annotations.PropertyStrategy;&#xA;</xsl:text>
            <xsl:text>import java.math.BigDecimal;&#xA;</xsl:text>
            <xsl:text>import java.util.Date;&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>@Entity&#xA;</xsl:text>
            <xsl:text>public class </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>{&#xA;</xsl:text>
            <xsl:apply-templates select="./field" mode="variable"/>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>() {}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>(</xsl:text>
            <xsl:apply-templates select="./field" mode="param"/>
            <xsl:text>) {&#xA;</xsl:text>
            <xsl:apply-templates select="./field" mode="assign"/>
            <xsl:text>}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="./field" mode="setter-getter"/>
            <xsl:text>    public static Builder builder() {&#xA;</xsl:text>
            <xsl:text>        return new </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>.Builder();&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>    public static class Builder {&#xA;</xsl:text>
            <xsl:text>        private Builder() {}&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="./field" mode="variable"/>
            <xsl:text>&#xA;</xsl:text>
            <xsl:apply-templates select="./field" mode="with"/>
            <xsl:text>        public </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text> build() {&#xA;</xsl:text>
            <xsl:text>            final </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text> result = new </xsl:text>
            <xsl:value-of select="./@name"/>
            <xsl:text>();&#xA;</xsl:text>
            <xsl:apply-templates select="./field" mode="build"/>
            <xsl:text>            return result;&#xA;</xsl:text>
            <xsl:text>        }&#xA;</xsl:text>
            <xsl:text>    }&#xA;</xsl:text>
            <xsl:text>}&#xA;</xsl:text>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

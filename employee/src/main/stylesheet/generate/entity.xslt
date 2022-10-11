<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text"/>

    <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
    <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>

    <xsl:template match="field" mode="variable">
    <xsl:if test="./@key">@PartitionKey</xsl:if>
    private <xsl:value-of select="./@type"/><xsl:text> </xsl:text><xsl:value-of select="translate(./@name,$upper,$lower)"/>;
    </xsl:template>
    <xsl:template match="field" mode="param">
        <xsl:if test="position()&gt;1">,</xsl:if> final <xsl:value-of select="./@type"/><xsl:text> </xsl:text><xsl:value-of select="translate(./@name,$upper,$lower)"/>
    </xsl:template>
    <xsl:template match="field" mode="assign">
        this.<xsl:value-of select="translate(./@name,$upper,$lower)"/> = <xsl:value-of select="translate(./@name,$upper,$lower)"/>;
    </xsl:template>

    <xsl:template match="field" mode="setter-getter">
    public <xsl:value-of select="./@type"/> get<xsl:value-of select="./@name"/>() {
        return <xsl:value-of select="translate(./@name,$upper,$lower)"/>;
    }
    public void set<xsl:value-of select="./@name"/>(final <xsl:value-of select="./@type"/> value) {
        this.<xsl:value-of select="translate(./@name,$upper,$lower)"/> = value;
    }
    </xsl:template>

    <xsl:template match="field" mode="with">
    public Builder with<xsl:value-of select="./@name"/>(final <xsl:value-of select="./@type"/> value) {
        this.<xsl:value-of select="translate(./@name,$upper,$lower)"/> = value;
        return this;
    }
    </xsl:template>

    <xsl:template match="field" mode="build">
        result.<xsl:value-of select="translate(./@name,$upper,$lower)"/> = <xsl:value-of select="translate(./@name,$upper,$lower)"/>;
    </xsl:template>

    <xsl:template match="/">
package de.thaso.demo.examples.simplepayroll.employee.entity;

import com.datastax.oss.driver.api.mapper.annotations.Entity;
import com.datastax.oss.driver.api.mapper.annotations.PartitionKey;
import com.datastax.oss.driver.api.mapper.annotations.PropertyStrategy;
import java.math.BigDecimal;

@Entity
public class <xsl:value-of select="/entity/@name"/> {
        <xsl:apply-templates select="/entity/field" mode="variable"/>

        public <xsl:value-of select="/entity/@name"/>() {}

        public <xsl:value-of select="/entity/@name"/>(
        <xsl:apply-templates select="/entity/field" mode="param"/>
        ) {
        <xsl:apply-templates select="/entity/field" mode="assign"/>
        }

        <xsl:apply-templates select="/entity/field" mode="setter-getter"/>

        public static Builder builder() {
        return new <xsl:value-of select="/entity/@name"/>.Builder();
        }

        public static class Builder {
        private Builder() {}

        <xsl:apply-templates select="/entity/field" mode="variable"/>
        <xsl:apply-templates select="/entity/field" mode="with"/>

        public <xsl:value-of select="/entity/@name"/> build() {
        final <xsl:value-of select="/entity/@name"/> result = new <xsl:value-of select="/entity/@name"/>();
        <xsl:apply-templates select="/entity/field" mode="build"/>
        return result;
        }
    }
}
</xsl:template>
</xsl:stylesheet>

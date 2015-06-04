<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="http://xml.apache.org/xalan/java"
                xmlns:lav="http://software.in2p3.fr/lavoisier/config.xsd"
                xmlns="http://software.in2p3.fr/lavoisier/config.xsd">

    <xsl:template match="lav:connector[java:exists(java:java.io.File.new(concat(java:java.lang.System.getProperty('basedir'),'/etc/stubs/',parent::lav:view/@name,'.xml')))]">
        <connector type="FileConnector">
            <parameter name="path">
                <xsl:value-of select="concat('stubs/',parent::lav:view/@name,'.xml')"/>
            </parameter>
        </connector>
    </xsl:template>
    <xsl:template match="lav:serializer[java:exists(java:java.io.File.new(concat(java:java.lang.System.getProperty('basedir'),'/etc/stubs/',parent::lav:view/@name,'.xml')))]"/>

    <xsl:template match="lav:processors/lav:elements[@depth]">
        <xsl:param name="depth" select="number(@depth)"/>
        <xsl:param name="base" select="@path"/>
        <xsl:param name="path" select="string(@path)"/>
        <xsl:if test="$depth > 0">
            <xsl:copy>
                <xsl:attribute name="path"><xsl:value-of select="$path"/></xsl:attribute>
                <xsl:copy-of select="*|text()|comment()"/>
            </xsl:copy>
            <xsl:apply-templates select="self::lav:elements">
                <xsl:with-param name="depth" select="$depth - 1"/>
                <xsl:with-param name="base" select="$base"/>
                <xsl:with-param name="path" select="concat($path, '/', $base)"/>
            </xsl:apply-templates>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="@*|*|text()|comment()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="@*">
        <xsl:copy/>
    </xsl:template>
</xsl:stylesheet>
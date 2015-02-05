<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <xsl:copy-of select="document('/lavoisier/head')"/>
            <body>
                <div data-spy="scroll" data-target=".subnav" data-offset="50">
                    <xsl:copy-of select="document('/lavoisier/navbar')"/>
                </div>
                <xsl:apply-templates select="/html_output"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>



</xsl:stylesheet>
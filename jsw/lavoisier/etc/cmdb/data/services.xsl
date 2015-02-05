<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>

    <xsl:template match="/families">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>CMDBuild dependencies</title>
            </head>
            <body>
                <script type="text/vnd.graphviz" id="dot">
digraph G {
    graph [style=dotted, overlap=false];
    node [style=filled];
    <xsl:apply-templates select="family | service"/>
    <xsl:apply-templates select=".//depends"/>
}
                </script>
                <script src="http://mdaines.github.io/viz.js/viz.js"/>
                <script>//<![CDATA[
function printStackTrace(s) {
    return "<pre>" + s.replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\"/g, "&quot;") + "</pre>"
}
function toSVG() {
    try {return Viz(document.getElementById("dot").innerHTML, "svg", "dot");}
    catch(e) {return printStackTrace(e.toString());}
}
document.body.innerHTML += toSVG();
//]]></script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="family">
    subgraph cluster_<xsl:value-of select="@name"/> {
        label = "<xsl:value-of select="@name"/>";
        <xsl:apply-templates select="service"/>
    }
    </xsl:template>

    <xsl:template match="service">
        "<xsl:value-of select="@name"/>";
    </xsl:template>

    <xsl:template match="service/depends">
        "<xsl:value-of select="@on"/>" -&gt; "<xsl:value-of select="parent::service/@name"/>";
    </xsl:template>
    <xsl:template match="family/depends">
        <xsl:variable name="on" select="@on"/>
        <xsl:for-each select="parent::family/service">
            "<xsl:value-of select="$on"/>" -&gt; "<xsl:value-of select="@name"/>";
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
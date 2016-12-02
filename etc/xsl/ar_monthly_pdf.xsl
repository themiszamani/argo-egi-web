<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:e="http://software.in2p3.fr/lavoisier/entries.xsd" version="1.0">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>

    <xsl:template match="/e:entries/e:entries">

        <html>
            <head>
                <style type="text/css">

                    body {
                    width: auto!important;
                    margin: auto!important;
                    font-family: serif;
                    font-size: 12pt;
                    background-color: #fff!important;
                    color: #000!important;
                    }
                    p, h1, h2, h3, h4, h5, h6, blockquote, ul, ol {
                    color: #000!important;
                    margin: auto!important;
                    }
                    .print {
                    display: block; /* affichage des éléments de classe print */
                    }
                    p, blockquote {
                    orphans: 3; /* pas de ligne seule en bas */
                    widows: 3; /* pas de ligne seule en haut */
                    }
                    blockquote, ul, ol {
                    page-break-inside: avoid; /* pas de coupure dans ces élements */
                    }
                    h1 {
                    page-break-before: always; /* chaque titre commence sur une nouvelle page */
                    }
                    h1, h2, h3, caption {
                    page-break-after: avoid; /* pas de saut après ces éléments */
                    }
                    a {
                    color: #000!important;
                    text-decoration: underline!important;
                    }
                    a[href]:after {
                    content: " (" attr(href) ")"; /* affichage des URL des liens */
                    }

                    table, table td, table th {
                    font-size: 8pt;
                    border: 1px solid black;
                    }


                    tr { text-align: center; }
                    th { background-color: #f2f1ec; padding: 1px; }

                    .success { background-color:#c9e2b3; padding: 1px; }
                    .critical { background-color:#e4b9c0; padding: 1px; }

                </style>

            </head>
            <body>

                <div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th></th>
                                <th colspan="5">Availabilities</th>
                                <th colspan="5">Reliabilities</th>
                            </tr>
                            <tr>
                                <xsl:choose>

                                    <xsl:when test="ancestor::e:entries/@view!='ngi_reports'">
                                        <th>Site</th>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <th>NGI</th>
                                    </xsl:otherwise>

                                </xsl:choose>



                                <xsl:for-each select="e:entry[1]/Availability">
                                    <th>
                                        <xsl:value-of select="@timestamp"/>
                                    </th>
                                </xsl:for-each>

                                <xsl:for-each select="e:entry[1]/Availability">
                                    <th>
                                        <xsl:value-of select="@timestamp"/>
                                    </th>
                                </xsl:for-each>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select="e:entry"></xsl:apply-templates>
                        </tbody>
                    </table>
                </div>



            </body>
        </html>
    </xsl:template>

    <xsl:template match="e:entry">

        <tr>
            <th><xsl:value-of select="@key"></xsl:value-of></th>
            <xsl:for-each select="Availability">

                <xsl:choose>
                    <xsl:when test="@availability &gt;= 80">
                        <td class="success" id="success"><xsl:value-of select="format-number(@availability,'#.00')"></xsl:value-of></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td class="critical" id="critical"><xsl:value-of select="format-number(@availability,'#.00')"></xsl:value-of></td>                        
                    </xsl:otherwise>
                </xsl:choose>
            
            </xsl:for-each>
            <xsl:for-each select="Availability">

                <xsl:choose>
                    <xsl:when test="@reliability &gt;= 85">
                        <td class="success" id="success"><xsl:value-of select="format-number(@reliability,'#.00')"></xsl:value-of></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td class="critical" id="critical"><xsl:value-of select="format-number(@reliability,'#.00')"></xsl:value-of></td>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:for-each>
        </tr>



</xsl:template>


</xsl:stylesheet>
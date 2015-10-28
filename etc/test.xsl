<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cfg="http://software.in2p3.fr/lavoisier/config.xsd">
    <xsl:include href="/resource/xsl/head.xsl"></xsl:include>
    <xsl:include href="/lavoisier/navbar"></xsl:include>
    <xsl:output encoding="utf-8" indent="yes" method="html"></xsl:output>

    <xsl:template match="/cfg:view">
        <html>
            <xsl:call-template name="head"></xsl:call-template>
            <body>
                <xsl:call-template name="navbar"></xsl:call-template>
                <div class="container">
                    <h2 class="page-title text-center"><xsl:value-of select="@name"></xsl:value-of></h2>
                    <xsl:for-each select="cfg:info/cfg:description">
                        <div class="well"><xsl:value-of select="."></xsl:value-of></div>
                    </xsl:for-each>
                    <form class="form-horizontal" id="form" method="get" role="form" target="_blank">
                        <xsl:for-each select="cfg:argument">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="{@name}"><xsl:value-of select="@name"></xsl:value-of></label>
                                <div class="col-sm-10">
                                    <xsl:choose>
                                        <xsl:when test="contains(@pattern,&apos;|&apos;) and not(contains(@pattern, &apos;[&apos;))">
                                            <select class="form-control" name="{@name}">
                                                <xsl:if test="not(text()!=&apos;&apos;)">
                                                    <option value="">*** Please select an item ! ***</option>
                                                </xsl:if>
                                                <xsl:call-template name="OPTIONS">
                                                    <xsl:with-param name="pattern" select="@pattern"></xsl:with-param>
                                                    <xsl:with-param name="default" select="text()"></xsl:with-param>
                                                </xsl:call-template>
                                            </select>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <input class="span4" name="{@name}" placeholder="{text()}" type="text"></input>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </div>
                        </xsl:for-each>

                        <div class="well">
                            <xsl:if test="count(cfg:authenticators/cfg:authenticator/cfg:value) &gt; 1">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="auth">Authentication</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="auth" name="auth">
                                            <option value="default">Default authentication</option>
                                            <xsl:for-each select="cfg:authenticators/cfg:authenticator/cfg:value">
                                                <option value="{text()}">
                                                    <xsl:value-of select="text()"></xsl:value-of>
                                                </option>
                                            </xsl:for-each>
                                        </select>
                                    </div>
                                </div>
                            </xsl:if>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="accept">Rendering</label>
                                <div class="col-sm-10">
                                    <select class="form-control" id="accept" name="accept">
                                        <xsl:variable name="selected" select="cfg:info/cfg:accept/text()"></xsl:variable>
                                        <option value="default">Default rendering</option>
                                        <xsl:for-each select="cfg:jmx/cfg:domain/cfg:group/cfg:mbean/cfg:attribute[@name=&apos;Extensions&apos;]/cfg:value[1][text()!=&apos;&apos;]">
                                            <option value="{text()}">
                                                <xsl:if test="text() = $selected">
                                                    <xsl:attribute name="selected">selected</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="text()"></xsl:value-of>
                                            </option>
                                        </xsl:for-each>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">XPath filter</label>
                                <div class="col-sm-10">
                                    <input class="form-control" id="xpath" name="xpath" placeholder="Enter XPath to filter output" type="text"></input>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Range</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <span class="input-group-addon">from</span>
                                        <input class="form-control" id="_window_start_" name="_window_start_" placeholder="Enter start of range here..." type="text" value="1"></input>
                                        <span class="input-group-addon">to</span>
                                        <input class="form-control" id="_window_end_" name="_window_end_" placeholder="Enter end of range here..." type="text"></input>
                                        <input id="_window_" name="_window_" type="hidden"></input>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group pull-right">
                            <input class="btn btn-lg" onclick="get()" type="submit" value="Get data"></input>
                        </div>
                    </form>
                </div>
                <script language="Javascript">
                    function get() {
                    if (document.getElementById('xpath').value != '') {
                    document.getElementById('form').action='/lavoisier/<xsl:value-of select="@name"></xsl:value-of>'+document.getElementById('xpath').value;
                    } else {
                    document.getElementById('form').action='/lavoisier/<xsl:value-of select="@name"></xsl:value-of>';
                    }
                    if (document.getElementById('auth') &amp;&amp; document.getElementById('auth').value == 'default') {
                    document.getElementById('auth').disabled=true;
                    }
                    if (document.getElementById('accept').value == 'default') {
                    document.getElementById('accept').disabled=true;
                    }
                    document.getElementById('_window_start_').disabled=true;
                    document.getElementById('_window_end_').disabled=true;
                    if (document.getElementById('_window_end_').value != '') {
                    document.getElementById('_window_').value = document.getElementById('_window_start_').value+'-'+document.getElementById('_window_end_').value;
                    } else {
                    document.getElementById('_window_').disabled=true;
                    }
                    $("#form input[type=text]").each(function() {
                    if (this.value == '') {
                    this.disabled = true;
                    }
                    })
                    }
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="OPTIONS">
        <xsl:param name="pattern"></xsl:param>
        <xsl:param name="default"></xsl:param>
        <xsl:choose>
            <xsl:when test="contains($pattern, &apos;|&apos;)">
                <xsl:variable name="current" select="substring-before($pattern, &apos;|&apos;)"></xsl:variable>
                <option value="{$current}">
                    <xsl:if test="$current = $default">
                        <xsl:attribute name="selected">selected</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$current"></xsl:value-of>
                </option>
                <xsl:call-template name="OPTIONS">
                    <xsl:with-param name="pattern" select="substring-after($pattern, &apos;|&apos;)"></xsl:with-param>
                    <xsl:with-param name="default" select="$default"></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <option value="{$pattern}">
                    <xsl:if test="$pattern = $default">
                        <xsl:attribute name="selected">selected</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$pattern"></xsl:value-of>
                </option>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
<!-- navbar.xsl -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cfg="http://software.in2p3.fr/lavoisier/config.xsd">
    <xsl:output method="html"/>
    <xsl:variable name="confView" select="document('conf')"/>

    <xsl:template match="/">

        <div class="container">
            <div class="header row">
                <div class="span12">
                    <div class="navbar">
                        <div class="navbar-inner">
                            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </a>
                            <h1>
                                <a class="brand">ARGO</a>
                            </h1>

                            <div class="nav-collapse collapse">
                                <ul class="nav pull-right navigation">
                                    <xsl:apply-templates select="menu/item"/>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>      

        </div>
    </xsl:template>


    <xsl:template match="item[@href]">
        <li>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="@href"/>
                </xsl:attribute>
                <i><xsl:attribute name="class">
                    <xsl:value-of select="@icon"/>
                </xsl:attribute></i><br/>
                <xsl:value-of select="@category"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="item[not(@href)]" mode="catList">
        <xsl:text/> or cfg:info/cfg:category/text()=&quot;<xsl:value-of select="@category"/>&quot;
    </xsl:template>


    <!-- build dropdown -->
    <xsl:template match="item[not(@href)]">
        <xsl:variable name="viewName" select="@category"/>
        <xsl:variable name="dropName" select="concat($viewName, '_drop')"/>
        <i><xsl:attribute name="class">
            <xsl:value-of select="@icon"/>
        </xsl:attribute></i>
        <li class="dropdown">
            <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                <xsl:attribute name="id">
                    <xsl:value-of select="$dropName"/>
                </xsl:attribute>
                <xsl:value-of select="$viewName"/>
                <b class="caret"/>
            </a>
            <ul class="dropdown-menu" role="menu">
                <xsl:attribute name="aria-labelledby">
                    <xsl:value-of select="$dropName"/>
                </xsl:attribute>
                <xsl:apply-templates select="$confView/cfg:config/cfg:view[cfg:info/cfg:category/text()= $viewName]"/>
            </ul>
        </li>
    </xsl:template>

    <!-- build dropdown menu -->
    <xsl:template match="cfg:view">
        <li>
            <a tabindex="-1">
                <xsl:attribute name="href">
                    <xsl:value-of select="concat('/lavoisier/', @name, cfg:info/cfg:path/text())"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:value-of select="cfg:info/cfg:description"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="not(cfg:info/cfg:label/text())">
                        <xsl:value-of select="@name"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="cfg:info/cfg:label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </li>
    </xsl:template>

</xsl:stylesheet>

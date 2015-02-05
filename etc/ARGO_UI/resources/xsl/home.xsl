<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <xsl:copy-of select="document('/lavoisier/head')"/>
            <body data-spy="scroll" data-target=".bs-docs-sidebar" data-twttr-rendered="true" data-offset="50">
                <xsl:copy-of select="document('/lavoisier/navbar')"/>

                <!-- Page Title -->
                <div class="page-title">
                    <div class="container">
                        <div class="row">
                            <div class="span12">
                                <i class="icon-home page-title-icon"></i>
                                <H2>Availability / Reliability Module </H2>

                            </div>
                        </div>
                    </div>
                </div>

                        <div class="what-we-do container">
                            <div class="row">

                                <div class="service span2"  style="height:300px; text-align:center;padding:10px">
                                    <div class="icon-awesome"><i class="icon-group"></i></div>
                                    <h4>VO Availability and Reliability</h4>
                                    <p>Availabilities / Reliabilities figures and charts group by type of services and VO</p>
                                    <br/><a href="/lavoisier/ar_vo">Link</a>
                                </div>

                                <div class="service span2"  style="height:300px;text-align:center;padding:10px">
                                    <div class="icon-awesome"><i class="icon-globe"></i></div>
                                    <h4>NGI Core Services Availability and Reliability</h4>
                                    <p>Availabilities / Reliabilities figures and charts of the core services of the NGIs</p>
                                    <a href="/lavoisier/ar_ngi">Link</a>

                                </div>

                                <div class="service span2"  style="height:300px;text-align:center;padding:10px">
                                    <div class="icon-awesome"><i class="icon-list"></i></div>
                                    <h4>NGI Availability and Reliability</h4>
                                    <p>Availabilities / Reliabilities figures and charts of the sites of the NGIs</p>
                                    <br/><a href="/lavoisier/ar_ngi_egi">Link</a>

                                </div>

                                <div class="service span2"  style="height:300px;text-align:center;padding:10px">
                                    <div class="icon-awesome"><i class="icon-book"></i></div>
                                    <h4>About the process of computation</h4>
                                    <p>Schema and documentation of the computation process</p>
                                    <br/><br/><a href="https://forge.in2p3.fr/projects/ar/wiki/Wiki">Link</a>

                                </div>
                            </div>
                        </div>









            </body>
        </html>
    </xsl:template>




</xsl:stylesheet>
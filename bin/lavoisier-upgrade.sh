#!/bin/sh
BASEDIR=`dirname $0`/..
BASEDIR=`(cd "$BASEDIR"; pwd)`

if [ "$1" != "release" -a "$1" != "snapshot" ] ; then
    echo "You must choose between options: release|snapshot"; exit 1
fi

echo "###"
echo "### Checking environment..."
echo "###"
which diff ; if [ $? -ne 0 ]; then echo "Missing command: diff"; exit 1; fi
which patch ; if [ $? -ne 0 ]; then echo "Missing command: patch"; exit 1; fi
which zip ; if [ $? -ne 0 ]; then echo "Missing command: zip"; exit 1; fi
which unzip ; if [ $? -ne 0 ]; then echo "Missing command: unzip"; exit 1; fi
which xmllint ; if [ $? -ne 0 ]; then echo "Missing command: xmllint"; exit 1; fi
which xsltproc ; if [ $? -ne 0 ]; then echo "Missing command: xsltproc"; exit 1; fi
which wget ; if [ $? -ne 0 ]; then echo "Missing command: wget"; exit 1; fi

OLD_ZIP=$BASEDIR/upgrade/*.zip
if [ ! -f $OLD_ZIP ] ; then echo "Missing ZIP file for old version in directory: $BASEDIR/upgrade/"; exit 1; fi

echo "###"
echo "### Stopping service..."
echo "###"
$BASEDIR/jsw/lavoisier/bin/lavoisier stop

echo "###"
echo "### Saving user configuration..."
echo "###"
rm -f $BASEDIR/upgrade/etc.patch $BASEDIR/upgrade/language.version
OLD_DIR=${TMP:-/tmp}/_old_/
mkdir -p $OLD_DIR
cd $OLD_DIR
    unzip -q $BASEDIR/upgrade/*.zip
    if [ $? -ne 0 ]; then echo "Failed to unzip old version"; exit 1; fi
    diff -rupN $OLD_DIR/*/etc/ $BASEDIR/etc/ > $BASEDIR/upgrade/etc.patch
cd -
rm -rf $OLD_DIR

NEW_DIR=${TMP:-/tmp}/_new_/
mkdir -p $NEW_DIR
cd $NEW_DIR
    wget http://maven.in2p3.fr/fr/in2p3/lavoisier/lavoisier-package/maven-metadata.xml
    if [ "$1" = "release" ] ; then
        VERSION=`xmllint --xpath '/metadata/versioning/release/text()' maven-metadata.xml`
        echo "###"
        echo "### Downloading latest release: $VERSION"
        echo "###"
        wget http://maven.in2p3.fr/fr/in2p3/lavoisier/lavoisier-package/$VERSION/lavoisier-package-$VERSION-bin.zip
    elif [ "$1" = "snapshot" ] ; then
        VERSION=`xmllint --xpath 'substring-before(/metadata/versioning/versions/version[contains(text(),"-SNAPSHOT")][last()]/text(),"-SNAPSHOT")' maven-metadata.xml`
        wget http://maven.in2p3.fr/fr/in2p3/lavoisier/lavoisier-package/$VERSION-SNAPSHOT/maven-metadata.xml
        BUILD=`xmllint --xpath 'concat(/metadata/versioning/snapshot/timestamp/text(),"-",/metadata/versioning/snapshot/buildNumber/text())' maven-metadata.xml.1`
        echo "###"
        echo "### Downloading latest snapshot: $VERSION ($BUILD)"
        echo "###"
        wget http://maven.in2p3.fr/fr/in2p3/lavoisier/lavoisier-package/$VERSION-SNAPSHOT/lavoisier-package-$VERSION-$BUILD-bin.zip
    fi
    if [ ! -f *.zip ]; then echo "Failed to download new version"; exit 1; fi
    rm -f maven-metadata.xml maven-metadata.xml.1

    echo "###"
    echo "### Installing new version..."
    echo "###"
    unzip -q *.zip
    if [ $? -ne 0 ]; then echo "Failed to unzip new version"; exit 1; fi
cd -

cd $NEW_DIR/*/etc/
    echo "###"
    echo "### Restoring user configuration..."
    echo "###"
    patch < $BASEDIR/upgrade/etc.patch
    if [ $? -ne 0 ]; then echo "Failed to apply patch"; exit 1; fi

    echo "###"
    echo "### Restoring language level..."
    echo "###"
    cat << EOF > $BASEDIR/upgrade/language-version.xsl
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lav="http://software.in2p3.fr/lavoisier/config.xsd">
    <xsl:template match="/lav:config"><xsl:copy><xsl:apply-templates select="@*"/><xsl:copy-of select="* | text() | comment()"/></xsl:copy></xsl:template>
    <xsl:template match="@version"><xsl:copy-of select="document('$BASEDIR/etc/lavoisier-config.xml')/lav:config/@version"/></xsl:template>
    <xsl:template match="@*"><xsl:copy-of select="."/></xsl:template>
</xsl:stylesheet>
EOF
    xsltproc $BASEDIR/upgrade/language-version.xsl lavoisier-config.xml > $BASEDIR/upgrade/lavoisier-config.xml
    if [ $? -ne 0 ]; then echo "Failed to change configuration language version"; exit 1; fi
    mv $BASEDIR/upgrade/lavoisier-config.xml lavoisier-config.xml
    rm $BASEDIR/upgrade/language-version.xsl
cd -

cd $NEW_DIR/*
    echo "###"
    echo "### Save installer for next upgrade..."
    echo "###"
    mkdir upgrade
    mv $NEW_DIR/*.zip upgrade
    mv $BASEDIR/upgrade/etc.patch upgrade
cd -

echo "###"
echo "### Upgraded version has been generated successfully: $NEW_DIR"
echo "###"

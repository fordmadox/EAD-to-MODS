<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs math xd"
    version="2.0">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 2, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> mc2343</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*/text()[normalize-space()]">
        <xsl:value-of select="replace(., '\n|\s+', ' ')"/>
    </xsl:template>
    
    <xsl:template match="*/text()[not(normalize-space())]"/>
    
    <!-- this is to fix an AT problem.  where else, aside from eventgrp elements, does it choke on mixed content??? 
        (I don't want to use DOE, and this won't always work,  but at least it helps fix some of the serialization problems introduced by the AT upon export)-->
    <xsl:template match="ead:eventgrp/ead:event/text()[matches(., '&lt;|&gt;')][not(contains(., '&amp;'))]" priority="2">
        <xsl:value-of select="replace(., '(&lt;)(&gt;)', '$1 $2')" disable-output-escaping="yes"/>
    </xsl:template>

    
</xsl:stylesheet>
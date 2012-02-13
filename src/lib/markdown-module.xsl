<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
xmlns:doc="http://www.xqdoc.org/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
exclude-result-prefixes="xs doc fn"
version="2.0">

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="source" as="xs:string"/>

  <!-- generate module html //-->
  <xsl:template match="//doc:xqdoc">
    <dummy>
    <xsl:apply-templates/>
    <xsl:text>

generated by xquerydoc &lt;https://github.com/xquery/xquerydoc&gt;</xsl:text>
    </dummy>
  </xsl:template>

  <xsl:template match="doc:module">
    <xsl:text># </xsl:text><xsl:value-of select="doc:uri"/><xsl:text> &#160;</xsl:text><xsl:value-of select="@type"/><xsl:text> module

</xsl:text>
    <xsl:apply-templates select="*[not(name(.) eq 'doc:uri')]"/>
  </xsl:template>

  <xsl:template match="doc:variables[empty(doc:variable)]">
  </xsl:template>

  <xsl:template match="doc:variables">
    <xsl:text>## Variables

</xsl:text>
      <xsl:apply-templates/>
    <xsl:text>

</xsl:text>
  </xsl:template>

  <xsl:template match="doc:variable[@private]"/>

  <xsl:template match="doc:variable">
    <xsl:text>### $</xsl:text><xsl:value-of select="doc:uri"/><xsl:text>
</xsl:text>
    <xsl:text>    $</xsl:text><xsl:value-of select="doc:uri"/><xsl:text> as </xsl:text><xsl:value-of select="doc:type"/><xsl:value-of select="doc:type/@occurrence"/><xsl:text>

</xsl:text>
    <xsl:apply-templates select="doc:comment"/>
  </xsl:template>

  <xsl:template match="doc:uri">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="doc:functions[empty(doc:function)]">
  </xsl:template>

  <xsl:template match="doc:functions">
    <xsl:text>## Functions

</xsl:text>
      <xsl:apply-templates/>
    <xsl:text>

</xsl:text>
  </xsl:template>

  <xsl:template match="doc:function[@private]"/>

  <xsl:template match="doc:function">
    <xsl:text>### </xsl:text><xsl:value-of select="doc:name"/><xsl:text>\#</xsl:text><xsl:value-of select="count(.//doc:parameter)"/><xsl:text>
</xsl:text>
    <xsl:text>    </xsl:text><xsl:value-of select="doc:name"/><xsl:value-of select="replace(doc:signature,'&#10;','&#10;    ')"/><xsl:text>

</xsl:text>
    <xsl:apply-templates select="* except (doc:name|doc:signature)"/>
  </xsl:template>

  <xsl:template match="doc:parameters">
    <xsl:text>#### Params
</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="doc:parameter">
    <xsl:text>* </xsl:text>
    <xsl:value-of select="doc:name"/><xsl:text> as </xsl:text><xsl:value-of select="doc:type"/><xsl:value-of select="doc:type/@occurrence"/>
    <xsl:variable name="name" select="string(doc:name)"/>
    <xsl:for-each select="../../doc:comment/doc:param[starts-with(normalize-space(.), $name)]">
      <xsl:value-of select="substring-after(normalize-space(.), $name)"/>
    </xsl:for-each>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="doc:return">
    <xsl:text>#### Returns
</xsl:text>
    <xsl:text>* </xsl:text>
    <xsl:value-of select="doc:type"/><xsl:value-of select="doc:type/@occurrence"/>
    <xsl:for-each select="../doc:comment/doc:return">
      <xsl:text>: </xsl:text>
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:for-each>
    <xsl:text>

</xsl:text>
  </xsl:template>

  <xsl:template match="doc:comment">
    <xsl:apply-templates mode="custom"/>
  </xsl:template>

  <xsl:template match="doc:description" mode="custom">
    <xsl:apply-templates mode="custom"/>
    <xsl:text>

</xsl:text>
  </xsl:template>

  <xsl:template match="*:h1" mode="custom">
    <xsl:text># </xsl:text><xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*:p" mode="custom">
    <xsl:apply-templates/>
    <xsl:text>

</xsl:text>
  </xsl:template>

  <xsl:template match="*:pre" mode="custom">
    <xsl:text>    </xsl:text><xsl:value-of select="replace(.,'&#10;','&#10;    ')"/>
  </xsl:template>

  <xsl:template match="doc:author" mode="custom">
    <xsl:text>Author: </xsl:text><xsl:value-of select="."/><xsl:text>

</xsl:text>
  </xsl:template>

  <xsl:template match="doc:version" mode="custom #default">
    <xsl:text>Version: </xsl:text><xsl:value-of select="."/><xsl:text>

</xsl:text>
  </xsl:template>

  <xsl:template match="doc:see" mode="custom">
    <!-- See also: -->
    <!-- <xsl:for-each select="tokenize(.,'[ \t\r\n,]+')[. ne '']"> -->
    <!--   <xsl:if test="position() ne 1"><xsl:text>, </xsl:text></xsl:if> -->
    <!--   <xsl:choose> -->
    <!--     <xsl:when test="contains(.,'#')"> -->
    <!--       <a href="#{ concat('func_', replace(substring-before(.,'#'), ':', '_'), -->
    <!--         '_', substring-after(.,'#')) }"> -->
    <!--         <xsl:value-of select="."/> -->
    <!--       </a> -->
    <!--     </xsl:when> -->
    <!--     <xsl:when test="starts-with(.,'$')"> -->
    <!--       <a href="#{ concat('var_', replace(substring-after(.,'$'), ':', '_')) }"> -->
    <!--         <xsl:value-of select="."/> -->
    <!--       </a> -->
    <!--     </xsl:when> -->
    <!--     <xsl:otherwise> -->
    <!--       <xsl:value-of select="."/> -->
    <!--     </xsl:otherwise> -->
    <!--   </xsl:choose> -->
    <!-- </xsl:for-each> -->
  </xsl:template>

  <xsl:template match="doc:param" mode="custom"/>
  <xsl:template match="doc:return" mode="custom"/>

  <!--xsl:template match="doc:custom" mode="custom">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="doc:param" mode="custom">
    <xsl:apply-templates select="."/>
  </xsl:template>


  <xsl:template match="doc:version" mode="custom">
    <xsl:apply-templates select="."/>
  </xsl:template-->

  <xsl:template match="doc:control"/>

  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>

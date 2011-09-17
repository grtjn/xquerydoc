<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
xmlns="http://www.w3.org/1999/xhtml"
xmlns:doc="http://www.xqdoc.org/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
exclude-result-prefixes="xs doc fn"
version="2.0">

<xsl:output method="xhtml" indent="no"/>

<xsl:param name="source" as="xs:string"/>
  <!-- generate module html //-->
  <xsl:template match="doc:xqdoc">
    <html>
      <head>
	<title>xqDoc - </title>
        <style type="text/css">
          body {
          font-family: Helvetica;
          padding: 0.5em  1em;
          }
          pre {
          font-family: Inconsolata, Consolas, monospace;
          }
          ol.results {
          padding-left: 0;
          }
          .footer {
          text-align:right;
          border-top: solid 4px;
          padding: 0.25em 0.5em;
          font-size: 85%;
          color: #999;
          }
          li.result {
          list-style-position: inside;
          list-style: none;
          height:140px;
          }
          .result h3 {
          font-weight: normal;
          font-size: inherit;
          margin: 0;
          }

          h2 {
          display: inline-block;
          margin: 0;
          }
          h2+div.stats {
          display: inline-block;
          margin-left: 1em;
          }
          h2 a,
          .result h3 a {
          text-decoration: inherit;
          color: inherit;
          }
          h3{
	  font-size: 140%;
	  background-color: #ddd;
	  border-bottom: 1px solid #99f;
	  width: 100%;
	  }

          .namespace {
          margin-left: 1em;
          color: #999;
          }
          .namespace:before {
          content: "{";
          }
          .namespace:after {
          content: "}";
          }
          table{
          width:75%;
          float:right;
          }
          td {
          height:100px;
          width:50%;
          vertical-align:text-top;
          }
        </style>

	<script src="src/tests/result/resource/prettify.js"
                type="text/javascript">&#160; </script>
	<script src="src/tests/result/resource/lang-xq.js"
                type="text/javascript">&#160; </script>
	<link rel="stylesheet" type="text/css" href="src/tests/result/resource/prettify.css">&#160;</link>


      </head>
      <body class="home">
	<div id="main">
          <xsl:apply-templates/>

          <h3>Source Code</h3>
          <pre class="prettyprint lang-xq"><xsl:value-of select="$source"/></pre>

        <div class="footer"><p
                                style="text-align:right"><i><xsl:value-of
                                select="current-dateTime()"/></i> |
        generated by xquerydoc <a
                                  href="https://github.com/xquery/xquerydoc"
                                  target="xquerydoc">https://github.com/xquery/xquerydoc</a></p></div>
        </div>

	<script type="application/javascript">
	  window.onload = function(){ prettyPrint(); }
	</script>

        <textarea rows="10" cols="80"><xsl:copy-of select="/."/></textarea>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="doc:module">
    <h1><xsl:value-of select="@type"/> module <span class="namespace"><xsl:value-of select="doc:uri"/></span></h1>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="doc:variables">
    <h3>Variables</h3>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="doc:variable">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="doc:functions">
    <h3>Functions</h3>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="doc:function">
    <h4><u>Function</u>&#160;<xsl:value-of select="doc:name"/><pre class="prettyprint lang-xq"><xsl:value-of select="doc:name"/><xsl:value-of select="doc:signature"/></pre></h4>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="doc:parameters">
    <h5>Params</h5>
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <xsl:template match="doc:parameter">
    <li><xsl:value-of select="doc:name"/>: <xsl:value-of select="doc:type"/></li>
  </xsl:template>

  <xsl:template match="doc:return">
    <h5>Returns</h5>
    <ul><li><xsl:value-of select="@occurrencee"/>: <xsl:value-of select="."/></li></ul>
  </xsl:template>

  <xsl:template match="doc:comment">
    <h5>Comment</h5>
    <xsl:apply-templates mode="custom"/>
  </xsl:template>

  <xsl:template match="doc:description" mode="custom">
    <p><xsl:apply-templates select="."/></p>
  </xsl:template>

  <xsl:template match="*:p" mode="custom">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="*:pre" mode="custom">
     <pre class="prettyprint lang-xq"><xsl:value-of select="."/></pre>
  </xsl:template>

  <xsl:template match="doc:author" mode="custom">
    Author: <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="doc:version">
    Version: <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="doc:version" mode="custom">
    v.<xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="doc:param" mode="custom">
    <xsl:apply-templates/>
  </xsl:template>

  <!--xsl:template match="doc:custom" mode="custom">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="doc:param" mode="custom">
    <xsl:apply-templates select="."/>
  </xsl:template>


  <xsl:template match="doc:version" mode="custom">
    <xsl:apply-templates select="."/>
  </xsl:template-->

  <xsl:template match="text()"/>

</xsl:stylesheet>

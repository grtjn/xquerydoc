<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="single-test"
    version="1.0"
    exclude-inline-prefixes="c ml p">

  <p:documentation>runs a single xquerydoc test in X environment</p:documentation>

  <!-- import Calabash library  //-->
  <p:import href="../lib/library-1.0.xpl"/>

  <!-- config file is main import //-->
  <p:input port="source"/>

  <!-- generate xml output which is transformed by report.xpl //-->
  <p:output port="result"/>

  <!-- path of test desired to be run, for example /tests/unit/simple.xqy //-->
  <p:option name="test" required="true"/>  

  <!-- path of example xquery containing xqdoc code comments //-->
  <p:option name="example" required="true"/>  

  <!-- path of xquerydoc dist //-->
  <p:variable name="distpath" select="/config/path"/>

  <!-- this step will run xquery test via XDBC //-->
  <p:xquery name="run"> 
    <p:with-param name="test" select="$test"/>
    <p:with-param name="example" select="$example"/>
    <p:with-param name="distpath" select="$distpath"/>
    <p:input port="query">
      <p:inline>
        <c:query>
          xquery version "1.0" encoding "UTF-8";

          import module namespace test = "http://www.marklogic.com/test" at "../lib/test.xqy";
          import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "../xquery/xquerydoc.xq";

          declare variable $distpath as xs:string external;
          declare variable $example as xs:string external;

          let $expected := fn:unparsed-text(fn:concat($distpath,'/src/tests/expected/default.xml'))
(:          let $actual  := xqdoc:parse(xdmp:quote(xdmp:document-get(fn:concat($distpath,$example)))) :)

          return
          &lt;test&gt;1&lt;/test&gt;

        </c:query>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:empty/>
    </p:input>    
  </p:xquery>

  <!-- emacs compile hint //-->
  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash -isource=config.xml -oresult=result/report.xml testrunner.xpl test=/tests/unit/simple.xqy example=/src/tests/examples/default.xqy"
    -- End:
    :)
  </p:documentation>

</p:declare-step>
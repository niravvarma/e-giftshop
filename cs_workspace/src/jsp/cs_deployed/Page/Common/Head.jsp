<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/Common/Head

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>

  <head>
    <meta charset="utf-8">
    <title>E-Gift Shop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Camping in the woods.">
    <meta name="author" content="Thomas Park">

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<render:lookup varname="TopNavJavaScriptVar" key="TopNavJavaScript" match=":x"/>
<render:callelement elementname='<%=ics.GetVar("TopNavJavaScriptVar")%>' >
    <render:argument name="cid" value='<%=ics.GetVar("cid")%>'/>
</render:callelement>

<%-- Display the locale selection form.  We'll rely on javascript to set the
     input c and cid variables.  Locale, however, we do have to set so that
     any language on the form can be appropriately translated. --%>
<render:lookup varname="LocaleForm" key="LocaleForm" match=":x"/>
<render:satellitepage pagename='<%=ics.GetVar("LocaleForm")%>'>
    <render:argument name="sitepfx" value='<%=ics.GetVar("sitepfx")%>'/>
    <render:argument name="site" value='<%=ics.GetVar("site")%>'/>
    <render:argument name="locale" value='<%=ics.GetVar("locale")%>'/>
</render:satellitepage>

    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="/static/css/bootswatch.css" rel="stylesheet">
	<link href="/static/css/thumbnail.css" rel="stylesheet">
	
	<script type="text/javascript" src="/static/js/jquery-1.8.0.min.js"></script>
	<script src="/static/js/bootstrap.min.js"></script>
	<script src="/static/js/cardcheck.js"></script>
	
  </head>

</cs:ftcs>
<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ taglib prefix="string" uri="futuretense_cs/string.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/Common/GetLink

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>


<%
String pageName=ics.GetVar("pageName");
%>
<asset:load name="currentPage" type="Page" field="name" value='<%=pageName %>' site='<%=ics.GetVar("site") %>' flushonvoid="true"/>
<asset:get name="currentPage" field="id" output="assetid"/>

<render:gettemplateurl outstr="curlink" site='<%=ics.GetVar("site") %>' slotname="navitem"
	tname="/EGiftShop_Layout"
	tid='<%=ics.GetVar("eid") %>'
	ttype='CSElement'
	c='Page'
	cid='<%=ics.GetVar("assetid")%>'
	wrapperpage="EGiftShop_Wrapper">
	<render:argument name="pName" value='<%=pageName %>' />
</render:gettemplateurl>

<string:encode varname='<%=pageName%>' variable="curlink" />

</cs:ftcs>
<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld" %>
<%@ taglib prefix="ics" uri="futuretense_cs/ics.tld" %>
<%@ taglib prefix="render" uri="futuretense_cs/render.tld" %>
<%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld" %>
<%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Forms/LogoutUser

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<ics:logmsg msg="Inside logoutUser CSElement......"/>
   <%-- log the user out --%>
    <%
    	ics.RemoveSSVar("UserLogged"); 
    	ics.RemoveSSVar("VisitorUserName");
    	ics.RemoveVar("userLogged");
    %>

	<ics:removessvar name="VisitorUserName"/>

    <%-- Discard the visitor object (this also creates a new one) --%>
    <commercecontext:logout/>
    <%-- calculate segments and promotions for the new visitor object --%>
    <commercecontext:calculatesegments/>
    <commercecontext:calculatepromotions/>

</cs:ftcs>
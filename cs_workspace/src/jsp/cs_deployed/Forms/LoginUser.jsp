<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="vdm" uri="futuretense_cs/vdm.tld" %>
<%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Forms/LoginUser

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<ics:logmsg msg="Inside loginUser CSElement......"/>

<ics:setssvar name="VisitorUserName" value='<%= ics.GetVar("VisitorUserName") %>'/>
<%-- <ics:setssvar name="VisitorID" value='<%= ics.GetVar("VisitorID") %>'/> --%>
    
<%-- Link the user to the current visitor object --%>
    <vdm:setalias key="SiteVisitor" value='<%= ics.GetVar( "VisitorUserName" ) %>'/>
    <%
    	ics.SetSSVar("UserLogged", "Yes");
    %>

    <%-- calculate the segments for the visitor --%>
    <commercecontext:calculatesegments/>
    <commercecontext:calculatepromotions/>

</cs:ftcs>
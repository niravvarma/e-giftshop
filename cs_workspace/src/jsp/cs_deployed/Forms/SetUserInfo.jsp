<%@page import="java.util.Random"%>
<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld" %>
<%@ taglib prefix="ics" uri="futuretense_cs/ics.tld" %>
<%@ taglib prefix="render" uri="futuretense_cs/render.tld" %>
<%@ taglib prefix="asset" uri="futuretense_cs/asset.tld" %>
<%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld" %>
<%@ taglib prefix="vdm" uri="futuretense_cs/vdm.tld" %>
<%@ taglib prefix="user" uri="futuretense_cs/user.tld" %>
<%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld" %>
<%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Forms/SetUserInfo

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<ics:logmsg msg="Inside setuserinfo CSElement...."/>

<%-- <user:login username="fwadmin" password="xceladmin"/>

<ics:catalogmanager>
				<ics:argument name="ftcmd" value="addrow"/>
				<ics:argument name="tablename" value="egsMember"/>
				<ics:argument name="Username" value='<%=ics.GetVar("Username") %>'/>
                <ics:argument name="Password" value='<%= ics.GetVar("Password") %>'/>
                <ics:argument name="FirstName" value='<%= ics.GetVar("FirstName") %>'/>
                <ics:argument name="Gender" value='<%= ics.GetVar("Gender") %>'/>
                <ics:argument name="LastName" value='<%= ics.GetVar("LastName") %>'/>                
</ics:catalogmanager> --%>
<%
Random rand = new Random();
int id = rand.nextInt(10000);

ics.SetVar("errno","0");
FTValList vl = new FTValList();
vl.put("ftcmd","addrow");
vl.put("tablename","egsMember");
vl.put("id",String.valueOf(id));
vl.put("username",ics.GetVar("Username"));
vl.put("password",ics.GetVar("Password"));
vl.put("firstname",ics.GetVar("FirstName"));
vl.put("lastname",ics.GetVar("LastName"));
vl.put("gender",ics.GetVar("Gender"));
ics.CatalogManager(vl);
%>

</cs:ftcs>
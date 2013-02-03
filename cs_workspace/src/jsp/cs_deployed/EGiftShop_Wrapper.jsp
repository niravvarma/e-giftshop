<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="cart" uri="futuretense_cs/cart.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- EGiftShop_Wrapper

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<ics:if condition='<%=ics.GetVar("p") == null%>'>
<ics:then>
	<ics:if condition='<%="Page".equals(ics.GetVar("c"))%>'>
	<ics:then>
		<%-- the asset being rendered is a page.  Use its id. --%>
		<ics:setvar name="p" value='<%=ics.GetVar("cid")%>'/>
	</ics:then>
	<ics:else>
        <ics:logmsg name="com.fatwire.logging.cs.firstsite" severity="warn" msg="Required variable 'p' is missing"/>
	</ics:else>
	</ics:if>
</ics:then>
</ics:if>

<ics:if condition='<%=ics.GetVar("packedargs") != null%>'>
<ics:then>
	<render:unpackarg unpack="pName" remove="true" packed='<%=ics.GetVar("packedargs")%>' outvar="packedargs"/>
</ics:then>
</ics:if>

<ics:if condition='<%=ics.GetVar("pName") != null%>'>
<ics:then>
     <ics:setvar name="pName" value='<%=ics.GetVar("pName")%>'/>
</ics:then>
<ics:else>
<asset:load name="currentPage" type='Page' flushonvoid="true" objectid='<%= ics.GetVar("cid") %>' />
<asset:get field="name" name="currentPage" output="pName"/>
</ics:else>     
</ics:if>

<ics:if condition='<%=ics.GetVar("packedargs") != null%>'>
<ics:then>
	<render:unpackarg unpack="form-to-process" remove="true" packed='<%=ics.GetVar("packedargs")%>' outvar="packedargs"/>
</ics:then>
</ics:if>
<ics:logmsg msg='<%="form-to-process: "+ ics.GetVar("form-to-process")%>'/>
<%-- If form-to-process is there, process it --%>

<ics:if condition='<%=ics.GetVar("form-to-process") != null%>'>
<ics:then>
    <render:lookup varname="formProcessingCSElement" key='<%=ics.GetVar("form-to-process")%>' ttype="CSElement" match=":x"/>
    <ics:if condition='<%=ics.GetVar("formProcessingCSElement")!=null%>'>
    <ics:then>
		<ics:logmsg name="com.fatwire.logging.cs.firstsite" severity="info" msg='<%="Wrapper processing form "+ics.GetVar("form-to-process")+" using element "+ics.GetVar("formProcessingCSElement")%>'/>
    	<render:callelement elementname='<%=ics.GetVar("formProcessingCSElement")%>' scoped="global"/>
		<ics:logmsg name="com.fatwire.logging.cs.firstsite" severity="debug" msg="...form processing complete"/>
    </ics:then>
    </ics:if>
</ics:then>
</ics:if>

<ics:logmsg msg='<%="UserloggedInWrapper: " + ics.GetSSVar("UserLogged") %>'/>

<ics:if condition='<%=ics.GetSSVar("UserLogged") != null%>'>
<ics:then>
     <ics:setvar name="userLogged" value='<%=ics.GetSSVar("UserLogged") %>'/>
</ics:then>
<ics:else>
	<ics:setvar name="userLogged" value='null'/>
</ics:else>
</ics:if>

<ics:if condition='<%=ics.GetSSVar("VisitorUserName") != null%>'>
<ics:then>
     <ics:setvar name="visitorUserName" value='<%=ics.GetSSVar("VisitorUserName") %>'/>
</ics:then>
<ics:else>
	<ics:setvar name="visitorUserName" value='null'/>
</ics:else>
</ics:if>

<ics:if condition='<%=ics.GetVar("form-to-render") == null%>'>
<ics:then>
     <ics:setvar name="form-to-render" value='None'/>
</ics:then>
</ics:if>

<%-- The session variable locale refers to the id of the dimension with the
     subtype of Locale that specifies which language the site is to be rendered
     in.  Users can select the locale of their choice from a menu on every page
     of the site, and once selected, it is stored in session.  A default locale
     is mapped to this CSElement and is set if it has not already been set.
     --%>
<ics:if condition='<%=ics.GetSSVar("preferred_locale") == null%>'>
    <ics:then>
        <render:lookup varname="default:locale:name" key='DefaultLocale' ttype="CSElement" match=":x"/>
        <asset:load name="defaultLocale" type="Dimension" field="name" value='<%=ics.GetVar("default:locale:name")%>'/>
        <asset:get name="defaultLocale" field="id" output="default:locale:id"/>
        <ics:setssvar name="preferred_locale" value='<%=ics.GetVar("default:locale:id")%>'/>
    </ics:then>
</ics:if>

<render:satellitepage pagename='<%=ics.GetVar("childpagename")%>' packedargs='<%=ics.GetVar("packedargs")%>'>
      <render:argument name='c' value='<%=ics.GetVar("c")%>'/>
      <render:argument name='cid' value='<%=ics.GetVar("cid")%>'/>
      <render:argument name='p' value='<%=ics.GetVar("p")%>' />
      <render:argument name="pName" value='<%=ics.GetVar("pName") %>'/>
      <%if(ics.GetVar("userLogged")!=null){ %>
  				<render:argument name="userLogged" value='<%=ics.GetVar("userLogged") %>'/>
  	  <%} %>
  	  <%if(ics.GetVar("visitorUserName")!=null){ %>
  				<render:argument name="visitorUserName" value='<%=ics.GetVar("visitorUserName") %>'/>
  	  <%} %>
  	  <render:argument name="form-to-render" value='<%=ics.GetVar("form-to-render") %>'/>
      <%-- <render:argument name="locale" value='<%=ics.GetSSVar("preferred_locale")%>'/> --%>
</render:satellitepage> 

</cs:ftcs>
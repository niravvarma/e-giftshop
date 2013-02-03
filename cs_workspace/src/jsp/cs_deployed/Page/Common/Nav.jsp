<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="string" uri="futuretense_cs/string.tld"
%><%@ taglib prefix="satellite" uri="futuretense_cs/satellite.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/Common/Nav

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<div class="navbar-inner">
     <div class="container">
       <render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='Home'/></render:callelement><a href='<%=ics.GetVar("Home")%>' class="brand">E-Gift Shop</a>
       <div id="main-menu" class="nav-collapse">
        <ul id="main-menu-left" class="nav">
          <li><a href='<%=ics.GetVar("Home")%>'>Home <i class="icon-home icon-white"></i> </a></li>
          <li class="dropdown">
            <a href='#' data-toggle="dropdown" class="dropdown-toggle">Shop <i class="icon-gift icon-white"></i></a>
            <ul id="swatch-menu" class="dropdown-menu">
              <li><render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='GiftCards'/> </render:callelement><a href='<%=ics.GetVar("GiftCards")%>'>Gift Cards</a></li>
              <li><render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='Apparel'/> </render:callelement><a href='<%=ics.GetVar("Apparel")%>'>Apparel</a></li>
            </ul>
          </li>
          <li><render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='ViewCart'/> </render:callelement><a href='<%=ics.GetVar("ViewCart")%>'>Cart <i class="icon-shopping-cart icon-white"></i> </a></li>
          <li><render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='Registration'/></render:callelement><a href='<%=ics.GetVar("Registration")%>'>Register <i class="icon-cog icon-white"></i></a></li>
          <li><render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='AboutUs'/> </render:callelement><a href='<%=ics.GetVar("AboutUs")%>'>About Site <i class="icon-info-sign icon-white"></i></a></li>
        </ul>
        
        <render:callelement elementname="Page/Common/LoginSection" args="c,cid">
        	<%if(ics.GetVar("userLogged")!=null){ %>
  				<render:argument name="userLogged" value='<%=ics.GetVar("userLogged") %>'/>
  	  		<%} %>
  	  		<%if(ics.GetVar("visitorUserName")!=null){ %>
  				<render:argument name="visitorUserName" value='<%=ics.GetVar("visitorUserName") %>'/>
  	  		<%} %>
        </render:callelement>
        
       </div>
     </div>
 </div>

</cs:ftcs>
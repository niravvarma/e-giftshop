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
%><cs:ftcs><%-- /EGiftShop_Layout

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>

<%-- Execute the Dimension filter to look up the translated asset that
     corresponds to the locale that the visitor requested. --%>
<render:lookup varname="Filter" key="Filter" match=":x" />
<render:callelement elementname='<%=ics.GetVar("Filter")%>' scoped="global"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <!-- Header starts -->
		<render:calltemplate tname="/Page/Common/Head" c='<%=ics.GetVar("c") %>' cid='<%=ics.GetVar("cid") %>'>
		</render:calltemplate>
    <!-- Header ends -->
 <body class="preview" data-spy="scroll" data-target=".subnav" data-offset="80">
    
    <!-- Navigation Bar starts -->
    <div class="navbar navbar-inverse navbar-fixed-top">
  			<render:callelement elementname="Page/Common/Nav" args="c,cid">
  			<%if(ics.GetVar("userLogged")!=null){ %>
  				<render:argument name="userLogged" value='<%=ics.GetVar("userLogged") %>'/>
  			<%} %>
  			<%if(ics.GetVar("visitorUserName")!=null){ %>
  				<render:argument name="visitorUserName" value='<%=ics.GetVar("visitorUserName") %>'/>
  			<%} %>
  			</render:callelement>	
	</div>
   <!-- Navigation Bar ends -->
   
   <%
   String tname=ics.GetVar("site")+"/"+ics.GetVar("pName")+"/Detail";
   if("Registration".equals(ics.GetVar("pName"))){
	   tname =ics.GetVar("site")+"/"+ics.GetVar("pName");%>
   <%}
   if("GiftCards".equals(ics.GetVar("pName")) || "Apparel".equals(ics.GetVar("pName"))){
	   tname ="Product_C/" + ics.GetVar("pName") + "/Detail";%>
   <%}
   %>
   <!-- Content starts -->
  	<div class="container">
  	<section class="content" style="margin-top:70px;">    
        	<render:calltemplate
				tname='<%=tname %>'   
				site='<%=ics.GetVar("site") %>' 
				tid='<%=ics.GetVar("tid") %>' 	
				c='<%=ics.GetVar("c") %>' 	
				cid='<%=ics.GetVar("cid") %>'
				slotname="body">
				<%if(ics.GetVar("userLogged")!=null){ %>
  					<render:argument name="userLogged" value='<%=ics.GetVar("userLogged") %>'/>
  				<%} %>
  				<%if(ics.GetVar("form-to-render")!=null){ %>
  					<render:argument name="form-to-render" value='<%=ics.GetVar("form-to-render") %>'/>
  	  			<%} %>
			</render:calltemplate>
	</section>
   <!-- Content ends -->		
     
	<!-- Footer starts -->
	<div class="row-fluid" style="margin-top:10px;">
    	<div class="span12 well">
            <render:calltemplate tname="/Page/Common/Footer" c='<%=ics.GetVar("c") %>' cid='<%=ics.GetVar("cid") %>'/>
        </div>  
</div>
        
    <!-- Footer ends -->
    </div>    

    
</body>
</html>



</cs:ftcs>
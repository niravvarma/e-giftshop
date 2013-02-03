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
%><cs:ftcs><%-- Page/Common/AddToCart

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<ics:logmsg msg="Inside AddToCart CSELement....."/>

<%-- Get the cart if it exists.  If no cart exists then this tag will initialize the new cart --%>
	<commercecontext:getcurrentcart varname="theCart"/>
	
	<%	
		 String	price = ics.GetVar("product-price").substring(1);
	%>
	
	<%-- Add the item to the cart --%>
	<cart:additem 
		name="theCart" 
		storeid="0" 
		type='<%=ics.GetVar("product-type")%>' 
		id='<%=ics.GetVar("product-id")%>' 
		quantity='<%=ics.GetVar("product-quantity")%>'
		price='<%=price%>'
		/>
	
	<%-- Re-set the cart --%>
	<commercecontext:setcurrentcart cart="theCart"/>
	
	<%-- That's all there is to it. --%>
	<div class="alert alert-success" style="clear:both;">
        	Item has been added to your cart.
    </div>

</cs:ftcs>
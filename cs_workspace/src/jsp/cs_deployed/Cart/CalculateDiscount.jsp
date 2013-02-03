<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ taglib prefix="cart" uri="futuretense_cs/cart.tld" 
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Cart/CalculateDiscount

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<ics:disablecache recursive="false"/>

<%--
	This element calculates the discount for the product passed in.
	
	Before calculating the discount you need to find out the segments the current user belongs to,
	the promotions that are valid for the user. Get a list of these promotions. 
--%>
<commercecontext:calculatesegments/>
<commercecontext:calculatepromotions/>
<commercecontext:getpromotions listvarname="promotionlist"/>

<%--
	To calculate the discount one needs to add the item to the shopping cart. This automatically
	calculates the discount. We create a temporary cart and add the item to the cart. 
--%>
<cart:create name="tmpcart"/>
<cart:cleardiscounts name="tmpcart"/>
<cart:additem name="tmpcart" storeid="0" type='<%= ics.GetVar("c") %>' id='<%= ics.GetVar("cid") %>' quantity="1" price='<%= ics.GetVar("Price")%>'/>
<cart:getitems name="tmpcart" listvarname="cartlist"/>
<commercecontext:discounttempcart cart="tmpcart"/>
<cart:getitemtotal name="tmpcart" varname="carttotal"/>
<%-- Set variables for the discount and new total --%>
<cart:getitemdiscounttotal name="tmpcart" varname="discounttotal"/>
<cart:getpreliminarytotal name="tmpcart" varname="total" />
<%-- Retrieve the description of the discount and set it as a variable for the caller --%>
<cart:getitemdiscounts name="tmpcart" id="0" listvarname="discountttotal"/>
<ics:if condition='<%=ics.GetList("discountttotal") != null && ics.GetList("discountttotal").hasData()%>'>
<ics:then>
	<ics:listget listname="discountttotal" fieldname="description" output="discountdescription"/>
</ics:then>
</ics:if>


</cs:ftcs>
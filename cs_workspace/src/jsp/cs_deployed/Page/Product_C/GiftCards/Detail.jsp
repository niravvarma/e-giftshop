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
                   com.fatwire.assetapi.data.*,
                   com.fatwire.assetapi.*,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%--

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>

<asset:load name="currentPage" type="Page" objectid='<%=ics.GetVar("cid") %>' flushonvoid="true" />
<asset:scatter name="currentPage" prefix="page" />

<%-- <render:gettemplateurlparameters outlist="args" args="c,cid,p" tname="/EGiftShop_Layout" wrapperpage='EGiftShop_Wrapper' site='<%=ics.GetVar("site") %>'>
        	<render:argument name="pagename" value='<%=ics.GetVar("page:name") %>'/>
 </render:gettemplateurlparameters> --%>

<assetset:setasset name="ProductSet" type='<%=ics.GetVar("c")%>' id='<%=ics.GetVar("cid")%>' />
<assetset:getattributevalues name="ProductSet" typename='PageAttribute' attribute='PageBody' listvarname="pageBodyList"/>
<assetset:getattributevalues name="ProductSet" typename='PageAttribute' attribute='GiftProducts' listvarname="giftProductsList"/>

<%if(ics.GetList("pageBodyList") != null && ics.GetList("pageBodyList").hasData()){%>
	<ics:listget listname='pageBodyList' fieldname='value' output='pageBody' />
<%} %>

<div class="span12" style="margin-left: 0;">
<div class="hero-unit">
<h1>Welcome to GiftCards Shop</h1>
<p>
<render:stream variable="pageBody"/>
</p>
</div>
<!-- <div class="row-fluid well">
<ul class="thumbnails"> -->
<div class="well" style="margin-left:0px;">       
        <ul class="thumbnails">
<ics:listloop listname="giftProductsList">
	<ics:listget listname="giftProductsList" output="giftProductID" fieldname="value"/>
			 	<render:calltemplate tname="EGiftShop/Shop/FullDetail" site='<%=ics.GetVar("site") %>' tid='<%=ics.GetVar("tid") %>' 	
					c='Gift_Product_C' cid='<%= ics.GetVar("giftProductID") %>' slotname="productList" style="element">
						<render:argument name="pagename" value='<%=ics.GetVar("page:name") %>'/>
						<render:argument name="pageID" value='<%=ics.GetVar("cid") %>'/>
				</render:calltemplate>
</ics:listloop>
</ul>
</div>
</div>

<%if("AddToCart".equals(ics.GetVar("form-to-render"))){ %>
	<%if("null".equals(ics.GetVar("userLogged")) || ics.GetVar("userLogged") == null) {%>
	<div class="alert" style="clear:both;">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		Please login to add items in your cart.
    </div>
    <% } else { %>
	<ics:logmsg msg="Adding product to CART with details as followed:"/>
    <ics:logmsg msg='<%="Product-ID: "+ics.GetVar("product-id") %>'/>
	<render:callelement elementname="Page/Common/AddToCart" scoped="global">
		<render:argument name="product-price" value='<%=ics.GetVar("product-price") %>'/>
		<render:argument name="product-type" value='<%=ics.GetVar("product-type") %>'/>
		<render:argument name="product-id" value='<%=ics.GetVar("product-id") %>'/>
		<render:argument name="product-quantity" value='<%=ics.GetVar("product-quantity") %>'/>
	</render:callelement>
<%} }%>

</cs:ftcs>

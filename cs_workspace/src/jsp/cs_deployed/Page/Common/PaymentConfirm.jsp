<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="string" uri="futuretense_cs/string.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="currency" uri="futuretense_cs/currency.tld"
%><%@ taglib prefix="cart" uri="futuretense_cs/cart.tld"
%><%@ taglib prefix="satellite" uri="futuretense_cs/satellite.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/Common/PaymentConfirm

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<div class="well">


<commercecontext:getcurrentcart varname="theCart"/>
<cart:getitems name="theCart" listvarname="ItemList"/>
<ics:if condition='<%=ics.GetList("ItemList") != null && ics.GetList("ItemList").hasData()%>'>
<ics:then>

Congrats <b><ics:getssvar name="VisitorUserName"/></b>!!
<p>Your payment has being processed and your product would be delivered to you in 0-7 days.</p>

    <table class="table table-bordered span6" style="float: inherit;">
		<caption><h3>Purchase Details</h3></caption>
		<thead>
			<tr>
				<th>Product Name</th>
				<th>Quantity</th>
				<th>Total</th>
			</tr>
		</thead>
		<tbody>
		<%
			double totalGlobalPrice = 0.0;
		%>
		<ics:listloop listname="ItemList">
		<%-- Get the name of the product --%>
		<ics:listget listname="ItemList" fieldname="assettype" output="assettype"/>
		<ics:listget listname="ItemList" fieldname="assetid" output="assetid"/>
		<assetset:setasset name="ProductInCart" type='Gift_Product_C' id='<%=ics.GetVar("assetid")%>' />
		<assetset:getattributevalues name="ProductInCart" typename='Gift_Product_A' attribute='GiftProductName' listvarname="ProdNameList"/>
		<assetset:getattributevalues name="ProductInCart" typename='Gift_Product_A' attribute='ProductThumb' listvarname="imageFile"/>
		<ics:listget listname="ProdNameList" fieldname="value" output="productName"/>
		<%-- Get the row id - used for modifying the cart --%>
		<ics:listget listname="ItemList" fieldname="rowid" output="rowid"/>
		
		<%-- Get the quantity of items --%>
		<ics:listget listname="ItemList" fieldname="quantity" output="quantity"/>

		<%-- Get the price --%>
		<ics:listget listname="ItemList" fieldname="price" output="price"/>

		<%-- Get the discounts for all the items in teh cart for the current row --%>
		<cart:getitemdiscounts name="theCart" id='<%=ics.GetVar("rowid")%>' listvarname="discountinfo"/>
		<ics:if condition='<%=ics.GetList("discountinfo") != null && ics.GetList("discountinfo").hasData()%>'>
		<ics:then>
			<ics:listget listname="discountinfo" fieldname="value" output="discountvalue"/>
			<ics:listget listname="discountinfo" fieldname="description" output="discountdescription"/>
		</ics:then>
		</ics:if>
		<%
			double unitPrice = Double.parseDouble(ics.GetVar("price"));
			double quantity = Double.parseDouble(ics.GetVar("quantity"));
			double finalUnitPrice = unitPrice;
			String sDiscount = ics.GetVar("discountvalue");
			ics.SetVar("discountvalue", ""); // we are in a loop so clean up for next iteration
			if (sDiscount!=null && sDiscount.length() > 0)
			{
				double discount = Double.parseDouble(sDiscount);
				finalUnitPrice = unitPrice - discount;
			}
			double totalPrice = finalUnitPrice * quantity;
			totalGlobalPrice = totalGlobalPrice + totalPrice;
		%>
		<currency:create name="currencyobj"/>
		<currency:getcurrency name="currencyobj" value='<%=Double.toString(unitPrice)%>' varname="formattedUnitPrice"/>
		<currency:getcurrency name="currencyobj" value='<%=(sDiscount!=null && sDiscount.length() > 0) ? sDiscount : "0" %>' varname="formattedDiscount"/>
		<currency:getcurrency name="currencyobj" value='<%=Double.toString(finalUnitPrice)%>' varname="formattedFinalUnitPrice"/>
		<currency:getcurrency name="currencyobj" value='<%=Double.toString(totalPrice)%>' varname="formattedTotalPrice"/>
		<currency:getcurrency name="currencyobj" value='<%=Double.toString(totalGlobalPrice)%>' varname="formattedGlobalTotalPrice"/>
		<currency:getsymbol varname="cursymbol" name="currencyobj"/>
		
			<tr>
				<td><%=ics.GetVar("productName")%></td>
				<td><string:stream variable="quantity"/></td>
				<td><string:stream variable="cursymbol"/><string:stream variable="formattedTotalPrice"/></td>
			</tr>
		</ics:listloop>
		<tr class="success">
			<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td><strong><string:stream variable="cursymbol"/><string:stream variable="formattedGlobalTotalPrice"/></strong></td>
		</tr>			
		</tbody>
    </table>
    
    <p>Thanks for purchasing from <b>E-Gift Shop</b>. Do visit again.</p>
</ics:then>
<ics:else>
	<p>Your cart is empty.</p>
</ics:else>
</ics:if>

</div>

<!-- clear cart after payment is done. -->
	<cart:clear name="theCart"/>

     <commercecontext:setcurrentcart cart="theCart"/>
<!-- Reset any segments and promotions in effect, in case we have a cart-based discount -->
	<commercecontext:calculatesegments/>
	<commercecontext:calculatepromotions/>

</cs:ftcs>
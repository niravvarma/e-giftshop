<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="string" uri="futuretense_cs/string.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="satellite" uri="futuretense_cs/satellite.tld"
%><%@ taglib prefix="cart" uri="futuretense_cs/cart.tld"
%><%@ taglib prefix="currency" uri="futuretense_cs/currency.tld"
%><%@ taglib prefix="blobservice" uri="futuretense_cs/blobservice.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/EGiftShop/ViewCart/Detail

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>


<asset:load name="currentPage" type="Page" objectid='<%=ics.GetVar("cid") %>' flushonvoid="true" />
<asset:scatter name="currentPage" prefix="page" />

<render:gettemplateurlparameters outlist="args" args="c,cid,p" tname="/EGiftShop_Layout" wrapperpage='EGiftShop_Wrapper' site='<%=ics.GetVar("site") %>'>
        	<render:argument name="pagename" value='<%=ics.GetVar("page:name") %>'/>
 </render:gettemplateurlparameters>


<% if("Yes".equals(ics.GetVar("userLogged"))){
	if("None".equals(ics.GetVar("form-to-render")) || "RemoveItems".equals(ics.GetVar("form-to-render"))){%>
<%-- Get the current cart --%>
<commercecontext:discountcart/>
<commercecontext:getcurrentcart varname="theCart"/>

<%-- get the contents from the cart --%>
<cart:getitems name="theCart" listvarname="ItemList"/>
<ics:if condition='<%=ics.GetList("ItemList") != null && ics.GetList("ItemList").hasData()%>'>
<ics:then>
		
	<satellite:form method="post" id='CartForm' name='CheckoutForm'>
	<ics:listloop listname="args">
		<input type="hidden" name="<string:stream list="args" column="name"/>" value="<string:stream list="args" column="value"/>"/>
	</ics:listloop>
	<input type="hidden" id="renderTo" name="form-to-render" value="CheckOutPost" />
	<div class="row-fluid">
	<div class="span12 well">
            <div class="accordion-group" style="background-color: #F5F5F5; border:none">
		<div class="accordion-heading" style="text-align: center;"> 
			<h3> SHOPPING CART </h3>
		</div>
	<table class="table table-bordered table-striped">
	
	<thead>
			  <tr>
				<th>Remove</th>
				<th>Image</th>
				<th>Product Name</th>
				<th>Quantity</th>
				<th>Unit Price</th>
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

		<%-- Get the discounts for all the items in the cart for the current row --%>
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
		<currency:getsymbol name="currencyobj" varname="cursymbol"/>

		<tr>
		<td><input type="checkbox" id="optionsCheckbox" name="rowid" value='<string:stream variable="rowid"/>'></td>
				<td class="muted center_text">
				<ics:if condition='<%=ics.GetList("imageFile")!=null && ics.GetList("imageFile").hasData()%>'>
      <ics:then>        

      <ics:listloop listname='imageFile'>
      <ics:listget listname='imageFile' fieldname='value' output='media_image' />
      
      <blobservice:gettablename varname="uTabname"/>
      <blobservice:getidcolumn varname="idColumn"/>
      <blobservice:geturlcolumn varname="uColumn"/>
      
      <render:getbloburl 
      blobtable='<%=ics.GetVar("uTabname")%>' 
      blobcol='<%=ics.GetVar("uColumn")%>'
      blobheader="image/jpeg"
      blobkey='<%=ics.GetVar("idColumn")%>'
      blobwhere='<%=ics.GetVar("media_image")%>' 
      outstr="imageURL"/> 

   	  </ics:listloop>
   
  		<img src='<%= ics.GetVar("imageURL") %>'>
  
      </ics:then>         
      </ics:if> 
					</td>
				<td><%=ics.GetVar("productName")%></td>
				<td><string:stream variable="quantity"/></td>
				<td><string:stream variable="cursymbol"/><string:stream variable="formattedFinalUnitPrice"/></td>
				<td><string:stream variable="cursymbol"/><string:stream variable="formattedTotalPrice"/></td>
		</tr>
		</ics:listloop>
	<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td><strong><string:stream variable="cursymbol"/><string:stream variable="formattedGlobalTotalPrice"/></strong></td>
	</tr>
	</tbody>
	</table>
	<div class="row-fluid">
          	<form class="form-horizontal">
		   	<fieldset>
		  	<div class="span5">
	            <button type="submit" class="btn btn-primary" id="update" name="form-to-process" value="RemoveItems">Update</button>
				</div>		  
				<div class="span7">
	            <button type="submit" class="btn btn-primary pull-right" name="form-to-process" value="Checkout">Checkout</button>
			</div>
			</fieldset>
        	</form>
    </div>
	</div>
</div>
</div>
	</satellite:form>
</ics:then>
<ics:else>
	<div class="alert">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		Hi <ics:getssvar name="VisitorUserName"/>, your cart is empty.
    </div>
</ics:else>
</ics:if>
<script>
$(document).ready(function() {
	$("#update").click(function() {
	    $("#renderTo").val("RemoveItems");
	});
});
</script>

<%} else if ("CheckOutPost".equals(ics.GetVar("form-to-render"))) {%>

<satellite:form method="post" name='BillingDetailsForm'>
<ics:listloop listname="args">
		<input type="hidden" name="<string:stream list="args" column="name"/>" value="<string:stream list="args" column="value"/>"/>
</ics:listloop>
<input type="hidden" name="form-to-render" value="PaymentPost" />
<div class="row-fluid">
	<div class="span12 well">
		<div class="accordion-group" style="background-color: #F5F5F5; border:none">
		<div class="accordion-heading" style="text-align: center;"> 
			<legend><h3> BILLING/DELIVERY DETAILS </h3></legend>
		</div>
	<div class="span6 no_margin_left">

						<legend>Your Personal Details</legend>
					  <div class="control-group">
						<label class="control-label">First Name*</label>
						<div class="controls docs-input-sizes">
						  <input type="text" class="input-xlarge" placeholder="" required="required">
						</div>
					  </div>
					  <div class="control-group">
						<label class="control-label">Last Name*</label>
						<div class="controls docs-input-sizes">
						  <input type="text" class="input-xlarge" placeholder="" required="required">
						</div>
					  </div>					  
					  <div class="control-group">
						<label class="control-label">Email Address*</label>
						<div class="controls docs-input-sizes">
						  <input type="email" class="input-xlarge" placeholder="Your email" required="required">
						</div>
					  </div>					 

					  <div class="control-group">
						<label class="control-label">Telephone*</label>
						<div class="controls docs-input-sizes">
						  <input type="tel" class="input-xlarge" placeholder="" required="required">
						</div>
					  </div>
					  </div>
					  <div class="span5">
					<legend>Your Address </legend>
					  <div class="control-group">
						<label class="control-label">Address 1*</label>
						<div class="controls docs-input-sizes">
						  <input type="text" class="input-xlarge" placeholder="" required>
						</div>
					  </div>
					  <div class="control-group">
						<label class="control-label">Address 2*</label>
						<div class="controls docs-input-sizes">
						  <input type="text" class="input-xlarge" placeholder="" required>
						</div>
					  </div>					  <div class="control-group">
						<label class="control-label">City*</label>
						<div class="controls docs-input-sizes">
						  <input type="text" class="input-xlarge" placeholder="" required>
						</div>
					  </div>
					  <div class="control-group">
						<label class="control-label">ZIP*</label>
						<div class="controls docs-input-sizes">
						  <input type="number" class="input-xlarge" placeholder="6-digit number" required maxlength="6">
						</div>
					  </div>					  
					  <div class="control-group">
						<label class="control-label">Country</label>
						<div class="controls docs-input-sizes">
							<select class="input-xlarge">
							<option>United Kingdom</option>
							<option>United States</option>
							</select>
						</div>
					  </div>
					  </div>
					  <div class="row-fluid">
			          	
					   	<fieldset>
					  	<legend></legend>
					  	<div style="text-align: center;"> 
							<legend><h3>PAYMENT DETAILS</h3> </legend>
						</div>
						
						<%-- Custom Payment Details --%>
						 <render:callelement elementname="Page/Common/CreditCardPayment"></render:callelement>   
            <%-- Custom Payment Ends --%>
            
            &nbsp;&nbsp;&nbsp;<legend></legend>
						<div style="border:none;" class="span11">
							<button type="submit" id="check-out" class="cc-checkout btn btn-primary pull-right">Continue</button>
						</div>
						</fieldset>
			        	
			    </div>
		</div></div>
	</div>
</satellite:form>

<%} else if ("PaymentPost".equals(ics.GetVar("form-to-render"))) {%>

	<render:callelement elementname="Page/Common/PaymentConfirm"></render:callelement>
	
<%} %>
<%  } else if("null".equals(ics.GetVar("userLogged")) || ics.GetVar("userLogged") == null){ %>
	<div class="alert">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		Please login or <render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='Registration'/></render:callelement><a href='<%=ics.GetVar("Registration")%>'>Register</a> to see cart details.
    </div>
<% } %>

</cs:ftcs>
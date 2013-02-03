<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="satellite" uri="futuretense_cs/satellite.tld"
%><%@ taglib prefix="string" uri="futuretense_cs/string.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Gift_Product_C/EGiftShop/Shop/FullDetail

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>

<%
	String imageAttr = "GiftProductImage";
%>

<assetset:setasset name="ProductSet" type='Gift_Product_C' id='<%=ics.GetVar("cid")%>' />
<assetset:getattributevalues name="ProductSet" typename='Gift_Product_A' attribute='GiftProductName' listvarname="productName" immediateonly='true'/>
<assetset:getattributevalues name="ProductSet" typename='Gift_Product_A' attribute='GiftProductCost' listvarname="productCost" immediateonly='true'/>
<assetset:getattributevalues name="ProductSet" typename='Gift_Product_A' attribute='<%=imageAttr %>' listvarname="productImage" immediateonly='true'/>
<assetset:getattributevalues name="ProductSet" typename='Gift_Product_A' attribute='GiftProductSummary' listvarname="productSummary" immediateonly='true'/>

<ics:if condition='<%=ics.GetList("productName")!=null && ics.GetList("productName").hasData()%>'><ics:then>
      <ics:listloop listname='productName'>
	      <ics:listget listname='productName' fieldname='value' output='pName' />
      </ics:listloop>
</ics:then></ics:if>

<ics:if condition='<%=ics.GetList("productCost")!=null && ics.GetList("productCost").hasData()%>'><ics:then>
      <ics:listloop listname='productCost'>
	      <ics:listget listname='productCost' fieldname='value' output='pCost' />
      </ics:listloop>
</ics:then></ics:if>

<ics:if condition='<%=ics.GetList("productSummary")!=null && ics.GetList("productSummary").hasData()%>'><ics:then>
      <ics:listloop listname='productSummary'>
	      <ics:listget listname='productSummary' fieldname='value' output='pSummary' />
      </ics:listloop>
</ics:then></ics:if>

<ics:if condition='<%=ics.GetList("productImage")!=null && ics.GetList("productImage").hasData()%>'><ics:then>
      <ics:listloop listname='productImage'>
	      <ics:listget listname='productImage' fieldname='value' output='productImageID' />
      </ics:listloop>
</ics:then></ics:if>

<%
	String renderLi = "<li class=\"span3\">";
	if("1".equals(ics.GetVar("liPos"))){
		renderLi = "<li class=\"span3\" style=\"margin-left:20px\">";
	}
%>	
<li class="span3" style="margin-left:20px">
            <div class="thumbnail">
              <div class="caption">
              	<render:calltemplate site='<%= ics.GetVar("site") %>' tid='<%= ics.GetVar("tid") %>' slotname="productImage" c='Media_C' 
					cid='<%=ics.GetVar("productImageID")%>' tname="EGiftShop/Media/Detail" style="element" >
				</render:calltemplate>
                
              </div>  
              <div class="thumbnail-pad">
              <h5><%=ics.GetVar("pName") %></h5>
              <%if(ics.GetVar("pSummary") !=null){ %>
                  <p><%=ics.GetVar("pSummary") %></p>
                  <%} %>
                  <p>Cost: <%=ics.GetVar("pCost") %> </p>
                  <render:gettemplateurlparameters outlist="args" c='Page' cid='<%=ics.GetVar("pageID") %>' tname="/EGiftShop_Layout" wrapperpage='EGiftShop_Wrapper' site='<%=ics.GetVar("site") %>'>
        				<render:argument name="pagename" value='<%=ics.GetVar("pagename") %>'/>
 				  </render:gettemplateurlparameters>
                <satellite:form method="post">
	                <ics:listloop listname='args'>
						<input type="hidden" name='<string:stream list='args' column="name"/>' value="<string:stream list='args' column="value"/>"/>
					</ics:listloop>
					<input type="hidden" name="form-to-render" value="AddToCart" />
					<input type="hidden" name="product-price" value='<%=ics.GetVar("pCost") %>' />
					<input type="hidden" name="product-type" value="Gift_Product_C"/>
					<input type="hidden" name="product-id" value='<%=ics.GetVar("cid") %>'/>
					<input type="text" class="input-mini" style="margin-top:10px;" name="product-quantity" size="2" value="1"/>
	                <button class="btn btn_" type="submit" style="padding:4px;">Add to Cart</button>
                </satellite:form>  
              </div>
            </div>
</li>

</cs:ftcs>
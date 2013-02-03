<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="satellite" uri="futuretense_cs/satellite.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/Common/CreditCardPayment

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<script>
	$(document).ready(function() {
		var creditCard = $('#credit-card');
		
		creditCard.cardcheck({
			iconLocation: '#accepted-cards-images',
			onReset: function() {			
				creditCard.parent().parent().removeClass().addClass('clearfix');
			},
			onError: function( type ) {
				creditCard.parent().parent().removeClass().addClass('clearfix invalid');
			},
			onValidation: function( type, niceName ) {
				creditCard.parent().parent().removeClass().addClass('clearfix valid');
			},
			// Occurs whenever the type changes. Usually within the first one to two characters typed
			onTypeUpdate: function( type, niceName ) {
				$('#credit-card-type-text').text(niceName);
			}
		});	
	});
</script>
			<div class="span6" style='margin-left:400px;'>
			
					<div class="control-group">
						<label class="control-label">Full Name*</label>
						<div class="controls docs-input-sizes">
						  <input type="text" class="input-xlarge" placeholder="" required="required">
						</div>
					  </div>
					  
					<div class="clearfix">
						<label for="credit-card">Card Number*</label>
						<div class="input">
							<input type="text" name="credit-card" id="credit-card" class="input-xlarge" required="required">
							<span class="help-inline" id="credit-card-type-text"></span>
						</div>
					</div>
					
					<div class="clearfix">
						<label>Accepted Cards</label>
						<div class="input">
							<div id="accepted-cards-images" class="pull-left">
								<!-- Icons Automatically Inserted Here -->
							</div>
					</div></div>
					</div>
<!-- 		</div>	
					<div class="actions"></div> -->

</cs:ftcs>
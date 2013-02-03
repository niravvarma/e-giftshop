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
%><cs:ftcs><%-- Page/Common/LoginSection

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

 <asset:load name="currentPage" objectid='<%=ics.GetVar("cid") %>' type="Page" site='<%=ics.GetVar("site")%>' flushonvoid="true"/>
 <asset:get name="currentPage" field="id" output="pageID"/>
 <asset:get name="currentPage" field="name" output="pagename"/>

<render:gettemplateurlparameters outlist="args" c='Page' cid='<%=ics.GetVar("pageID") %>' tname="/EGiftShop_Layout" wrapperpage='EGiftShop_Wrapper' site='<%=ics.GetVar("site") %>' ttype="CSElement" tid='<%=ics.GetVar("eid") %>'>
	<render:argument name="pagename" value='<%=ics.GetVar("pagename") %>'/>
</render:gettemplateurlparameters>

<ul id="main-menu-right" class="nav pull-right">
        <li class="divider-vertical"></li>
       
       
        <% if("null".equals(ics.GetVar("userLogged")) || ics.GetVar("userLogged")==null){ %>
         <!-- Login/Register -->
				        	<li>
				        	<satellite:form method="get" name="LoginForm" id="LoginForm" onsubmit="return validateLoginForm();" >
				          	<input type="text" id="Username" name="Username" required placeholder="Username" class="input-medium" style="margin: 4.5px 0;">
				          	<input type="password" id="Password" name="Password" required placeholder="Password" class="input-medium" style="margin: 4.5px 0;">
				          	<input type="hidden" name="form-to-process" value="LoginPost" />
				         	 <button class="btn btn-success" type="submit" style="margin-top: 1.5px;">Login <i class="icon-lock"></i></button>
				         	 <ics:listloop listname="args">
								<input type="hidden" name='<string:stream list="args" column="name"/>' value='<string:stream list="args" column="value"/>'/>
							</ics:listloop>
				          	</satellite:form>
						</li>
						        </ul>
		<%} else if ("Yes".equals(ics.GetVar("userLogged"))) { %>
				      	      <div class="btn-group open pull-right">
							    <%-- <a class="btn btn-primary" href="#"><i class="icon-user"></i> <ics:getssvar name="VisitorUserName"/></a> --%>
							    <button class="btn btn-medium" style="float: left;"><i class="icon-user"></i> <ics:getvar name="visitorUserName"/></button>
							    <satellite:form method="get" id="LogoutForm">
				      	  			<input type="hidden" name="form-to-process" value="LogoutUser" />
							      	  <ics:listloop listname="args">
											<input type="hidden" name='<string:stream list="args" column="name"/>' value='<string:stream list="args" column="value"/>'/>
									  </ics:listloop>
										    <button class="btn btn-danger" type="submit" style="margin-left:5px;"><i class="icon-off"></i></button>
							    </satellite:form>
							  </div>
		<%} %>


 <script type="text/javascript">
 
 $(document).ready(function() {
	 	$("#LoginForm").css('margin','0px');
	 	$("#LogoutForm").css('margin','0px');
	 	$("#LogoutForm").css('float','left');
	});
 </script>
 
 <script type="text/javascript">
// <![CDATA[
	function validateLoginForm()
	{
			// simple javascript to validate username/password
			document.getElementById("FormErrorArea").innerText = "";
			if (document.getElementById("Username").value == "" )
			{
					document.getElementById("FormErrorArea").style.visibility = "visible";
					document.getElementById("FormErrorArea").innerText = "Invalid username";
					document.getElementById("Username").focus();
					return false;
			}
			else if(document.getElementById("Password").value == "")
			{
					document.getElementById("FormErrorArea").style.visibility = "visible";
					document.getElementById("FormErrorArea").innerText = "Invalid password";
					document.getElementById("Password").focus();
					return false;
			}
			else
			{
				document.getElementById("FormErrorArea").style.visibility = "hidden";
				return true;
			}
	}
//]]>
</script>

</cs:ftcs>
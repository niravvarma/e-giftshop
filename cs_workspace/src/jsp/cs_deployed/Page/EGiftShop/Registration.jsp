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
%><cs:ftcs><%-- Page/EGiftShop/Registration

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>

<script type="text/javascript">
 $(document).ready(function(){
	 $("#RegisterForm").addClass("form-horizontal well");
 }); 
 </script>

<%if("null".equals(ics.GetVar("userLogged")) || ics.GetVar("userLogged") == null) {%>
<asset:load name="currentPage" type="Page" objectid='<%=ics.GetVar("cid") %>' flushonvoid="true" />
<asset:scatter name="currentPage" prefix="page" />

<render:gettemplateurlparameters outlist="args" args="c,cid,p" tname="/EGiftShop_Layout" wrapperpage='EGiftShop_Wrapper' site='<%=ics.GetVar("site") %>'>
        	<render:argument name="pagename" value='<%=ics.GetVar("page:name") %>'/>
 </render:gettemplateurlparameters>
 
<satellite:form method="post" id="RegisterForm"  onsubmit="return validateRegisterForm();">
        <fieldset style="align:center;">
          <legend >Welcome to E-Gift Shop Registration Page</legend>
			<ics:listloop listname="args">
					<input type="hidden" name='<string:stream list="args" column="name"/>' value="<string:stream list="args" column="value"/>"/>
			</ics:listloop>
          <div class="control-group">
            <label for="input01" class="control-label">Username</label>
            <div class="controls">
              <input type="text" id="user_name" class="input-large" name="Username" min="6" max="20" required data-content="Between 6 and 20" data-original-title="Username" placeholder="Enter username...">
            </div>
          </div>
          <div class="control-group">  
            <label for="input02" class="control-label">Password</label>
            <div class="controls">
              <input type="password" id="pwd" class="input-large" name="Password" min="6" max="20" required data-content="Between 6 and 20" data-original-title="Password" placeholder="Enter password...">
            </div>
          </div>
          <div class="control-group">
			<label class="control-label">Confirm Password</label>
			<div class="controls">
			<input type="password" class="input-large" id="cpwd" name="cpwd" min="6" max="20" data-content="Between 6 and 20" data-original-title="Confirm Password" required placeholder="Confirm password...">
			</div>
		</div>
          <div class="control-group">  
            <label for="input03" class="control-label">First Name</label>
            <div class="controls">
              <input type="text" id="fname" class="input-large" name="FirstName" data-content="Your First Name" data-original-title="First Name" required placeholder="Enter first name...">
            </div>
          </div>
          <div class="control-group">  
            <label for="input04" class="control-label">Last Name</label>
            <div class="controls">
              <input type="text" id="lname" class="input-large" name="LastName" data-content="Your Last Name" data-original-title="Last Name" required placeholder="Enter last name...">
            </div>
          </div>
          <div class="control-group">
            <label for="select01" class="control-label">Gender</label>
            <div class="controls">
              <select id="select01" name="Gender">
                <option>Male</option>
                <option>Female</option>
              </select>
            </div>
          </div>
          <input type="hidden" name="form-to-process" value="RegisterPost" />
          <div class="form-actions">
            <button class="btn btn-primary" type="submit" id="sub">Register <i class="icon-check"></i></button>&nbsp;&nbsp;&nbsp;
            <button class="btn" type="reset">Reset <i class="icon-refresh"></i></button>
          </div>
        </fieldset>
        <%if("Success".equals(ics.GetVar("Registration"))){ %>
        <div class="alert alert-success span6" style="margin-top:100px">
        	<a class="close">×</a>
        	<strong>User Registration was success!!!</strong>  Please login to Shop.
      	</div>
      	<ics:removevar name="Registration"/>
      	<%} else if ("Failed".equals(ics.GetVar("Registration"))){%>
      	<div class="alert alert-error">
        <a class="close">×</a>
        <strong>Error</strong> Change a few things up and try submitting again.
        </div>
        <ics:removevar name="Registration"/>
        <%} %>
 </satellite:form>
 <script>
 $(document).ready(function() {

 jQuery(function(){
     $("#sub").click(function(){
     $(".error").hide();
     var hasError = false;
     var passwordVal = $("#pwd").val();
     var checkVal = $("#cpwd").val();
     if (passwordVal == '') {
         $("#pwd").after('<span class="error" style="margin-left: 10px; color: red;">Please enter a password.</span>');
         hasError = true;
     } else if (checkVal == '') {
         $("#cpwd").after('<span class="error" style="margin-left: 10px; color: red;">Please re-enter your password.</span>');
         hasError = true;
     } else if (passwordVal != checkVal ) {
         $("#cpwd").after('<span class="error" style="margin-left: 10px; color: red;"> Passwords do not match.</span>');
         hasError = true;
     }
     if(hasError == true) {return false;}
 });
});
 });
 </script>
 <%} else if("Yes".equals(ics.GetVar("userLogged"))) { %>
 <div class="well">
        Welcome <b><ics:getssvar name="VisitorUserName"/></b>!!
        <p>You are already registered. Continue shopping or logout to register with different username.</p>
  </div>
<%} %>

</cs:ftcs>
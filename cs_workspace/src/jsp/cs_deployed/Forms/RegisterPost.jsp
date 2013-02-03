<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld" %>
<%@ taglib prefix="ics" uri="futuretense_cs/ics.tld" %>
<%@ taglib prefix="render" uri="futuretense_cs/render.tld" %>
<%@ taglib prefix="asset" uri="futuretense_cs/asset.tld" %>
<%@ taglib prefix="user" uri="futuretense_cs/user.tld" %>
<%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Forms/RegisterPost

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<ics:logmsg msg="Inside RegisterPost CSElement......"/>

    <render:lookup key="FindUser" match=":x" varname="FindUserCSElement" ttype="CSElement"/>
    
    <render:callelement scoped="local" elementname='<%=ics.GetVar("FindUserCSElement")%>'>
        <render:argument name="listname" value="theUserList"/>
        <render:argument name="username" value='<%= ics.GetVar("Username") %>'/>
    </render:callelement>

<!-- 
	If table does not exists, then create a tablename "egsMember" 
	-105 = table does not exists.
-->
	<ics:if condition='<%=ics.GetErrno() == -105%>'>
	<ics:then>
	<user:login username="fwadmin" password="xceladmin"/>
	<ics:catalogmanager>
	    <ics:argument name="ftcmd" value="createtable" />
	    <ics:argument name="tablename" value='<%=ics.GetVar("tablename")%>' />
	    <ics:argument name="systable" value="no" />
	    <!-- Fill the required form columns to be created -->
	    <ics:argument name="uploadDir" value="/export/home/public" />
	    <ics:argument name="colname0" value="id" />
    	<ics:argument name="colvalue0" value="varchar(10) PRIMARY KEY NOT NULL" />
	    <ics:argument name="colname1" value="Username" />
	    <ics:argument name="colvalue1" value="varchar(24)" />
	    <ics:argument name="colname2" value="Password" />
	    <ics:argument name="colvalue2" value="varchar(24)" />
	    <ics:argument name="colname3" value="FirstName" />
	    <ics:argument name="colvalue3" value="varchar(24)"/>
	    <ics:argument name="colname5" value="LastName" />
	    <ics:argument name="colvalue5" value="varchar(24)"/>
	    <ics:argument name="colname4" value="Gender" />
	    <ics:argument name="colvalue4" value="varchar(6)"/>
	</ics:catalogmanager>
		<ics:if condition='<%=ics.GetErrno() == -100%>'>
		    <ics:then>
		    	<ics:logmsg msg="Error while creating table \"egsMember\""/>
		    </ics:then>
		    <ics:else>	
		<!-- Then register the user -->	
							<render:lookup key="SetUserInfo" match=":x" varname="SetUserInfo" ttype="CSElement"/>
	                    	<ics:if condition='<%=ics.GetVar("SetUserInfo") != null%>'>
		                        <ics:then>
		                            <render:callelement elementname='<%=ics.GetVar("SetUserInfo")%>'>
		                                <render:argument name="Username" value='<%= ics.GetVar("Username") %>'/>
		                                <render:argument name="Password" value='<%= ics.GetVar("Password") %>'/>
		                                <render:argument name="FirstName" value='<%= ics.GetVar("FirstName") %>'/>
		                                <render:argument name="LastName" value='<%= ics.GetVar("LastName") %>'/>
		                                <render:argument name="Gender" value='<%= ics.GetVar("Gender") %>'/>
		                                <render:argument name="tablename" value='<%= ics.GetVar("tablename") %>'/>
		                            </render:callelement>
		                            <ics:logmsg msg="User registration completed by creating table...."/>
		                            <ics:setvar name="Registration" value="Success"/>
		                            <div class="span12">
        							<div class="alert alert-block span6" style="margin-top:100px">
                   						<h4 class="alert-heading">Congratulations!!</h4>
          	      						<p>Hi <%= ics.GetVar("Username") %>, your registration is completed. Kindly login to shop.</p>
       		 						</div>
  		   							</div>
		                        </ics:then>
		                        <ics:else>
		                        	<ics:setvar name="Registration" value="Failed"/>
		                        </ics:else>
		                    </ics:if>
			</ics:else>
		</ics:if>	
	</ics:then>
	<ics:else>
<!-- 
	If username already exists, then pass alert message 
	-101 = No search results from the table
-->
	<ics:if condition='<%=ics.GetErrno() == -101%>'>
	    <ics:then>
	    	        <render:lookup key="SetUserInfo" match=":x" varname="SetUserInfo" ttype="CSElement"/>
                    <ics:if condition='<%=ics.GetVar("SetUserInfo") != null%>'>
                        <ics:then>
                            <render:callelement elementname='<%=ics.GetVar("SetUserInfo")%>'>
                                <render:argument name="Username" value='<%= ics.GetVar("Username") %>'/>
                                <render:argument name="Password" value='<%= ics.GetVar("Password") %>'/>
                                <render:argument name="FirstName" value='<%= ics.GetVar("FirstName") %>'/>
                                <render:argument name="LastName" value='<%= ics.GetVar("LastName") %>'/>
                                <render:argument name="Gender" value='<%= ics.GetVar("Gender") %>'/>
                                <render:argument name="tablename" value='<%= ics.GetVar("tablename") %>'/>
                            </render:callelement>
                            <ics:logmsg msg="User registration completed without creating table...."/>
                            <ics:setvar name="Registration" value="Success"/>
                            <div class="span12">
        						<div class="alert alert-block span6" style="margin-top:100px">
                   					<h4 class="alert-heading">Congratulations!!</h4>
          	      					<p>Hi <%= ics.GetVar("Username") %>, your registration is completed. Kindly login to shop.</p>
       		 					</div>
  		   					</div>
                        </ics:then>
                    </ics:if>                
        </ics:then>
		<ics:else>
		<ics:setvar name="Registration" value="Failed"/>
			<div class="span12">
        	<div class="alert alert-block span6" style="margin-top:100px">
                   <h4 class="alert-heading">Error</h4>
          	      <p>A user with the username: <%= ics.GetVar("Username") %> already exists. Please choose another name.</p>
       		 </div>
  		   </div>
            <%-- Set the variable for the form to render back to the register form so the user can re-try --%>
            <%-- <render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='Registration'/> </render:callelement><a href='<%=ics.GetVar("Registration")%>'>TRY AGAIN</a> --%>
        </ics:else>
	</ics:if>
	</ics:else>
	</ics:if>

<%--     <ics:if condition='<%= ics.GetList("theUserList") != null && ics.GetList("theUserList").hasData() %>'>
        <ics:else>

            Create session variable to alert RemoteContentPost that a user is already logged on
            <ics:setssvar name="AlreadyLoggedIn" value="true"/>
            <ics:setssvar name="UserLoggedIn" value="Yes"/>

            Grab the visitor type from the reference list
            <render:lookup key="VisitorType" varname="_ASSET_" ttype="CSElement"/>

            Publication info is passed into the CSElement
            <ics:setvar name="publication" value='<%=ics.GetVar("site")%>'/>

            This is the edit version, so the action is update
            <ics:setvar name="Action" value="addrow"/>

            Look up the content definition type
            <render:lookup key="VisitorDefName" match=":x" varname="_DEFINITION_" ttype="CSElement"/>

            Automatically invent the name based on the user's input
            <render:lookup key="FirstNameAttr" match=":x" varname="FirstNameAttrName" ttype="CSElement"/>
            <render:lookup key="LastNameAttr" match=":x" varname="LastNameAttrName" ttype="CSElement"/>
            <ics:setvar name="_ITEMNAME_" value='<%=ics.GetVar("LastName") + ", " + ics.GetVar("FirstName")%>'/>

            Call RemoteContentPost to update the data
                 Hide the locale variable though RemoteContentPost does not get 
                 confused.
            <ics:setvar name="localedimid" value='<%=ics.GetVar("locale")%>'/>
            <ics:removevar name="locale" />
            <ics:callelement element="OpenMarket/Xcelerate/Actions/RemoteContentPost"/>
            <ics:setvar name="locale" value='<%=ics.GetVar("localedimid")%>' />
            <ics:removevar name="localedimid" /> 

            finally, update the visitor object
            <ics:if condition='<%=ics.GetErrno() >= 0%>'>
                <ics:then>
                    <render:lookup key="SetUserInfo" match=":x" varname="SetUserInfo" ttype="CSElement"/>
                    <ics:if condition='<%=ics.GetVar("SetUserInfo") != null%>'>
                        <ics:then>
                            <render:callelement elementname='<%=ics.GetVar("SetUserInfo")%>'>
                                <ics:argument name="VisitorID" value='<%= ics.GetVar("id") %>'/>
                                <ics:argument name="VisitorUserName" value='<%= ics.GetVar("Username") %>'/>
                            </render:callelement>
                            <ics:logmsg msg="User registration completed...."/>
                            <ics:setvar name="Registration" value="Success"/>               
                            <ics:setssvar  name="UserLoggedIn" value="No" />
                        </ics:then>
                    </ics:if>
                </ics:then>
                <ics:else>
                			<ics:logmsg msg="User registration failed...."/>
                            <ics:setvar name="Registration" value="Failed"/>               
                            <ics:setssvar  name="UserLoggedIn" value="No" />
                 </ics:else>
            </ics:if>
        </ics:else>
    </ics:if>
 --%>
</cs:ftcs>
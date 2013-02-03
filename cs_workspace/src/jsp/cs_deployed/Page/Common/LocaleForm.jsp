<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="string" uri="futuretense_cs/string.tld"
%><%@ taglib prefix="dimensionset" uri="futuretense_cs/dimensionset.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/Common/LocaleForm

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<%-- Load the home page node name so we can submit back to the home page --%>
<render:lookup varname="HomePageName" key="HomePage" ttype="CSElement" match=":x"/>
<asset:load name="HomePage" type="Page" field="name" value='<%=ics.GetVar("HomePageName")%>'/>
<asset:get name="HomePage" field="id" output="HomePageId"/>
<%-- Load the specified dimension set, then allow the user to choose the
     locale they want to view from the specified set. --%>
<render:lookup ttype="CSElement" key="GlobalDimSet" varname="GlobalDimSet" match=":x"/>
<asset:load name="DimSet" type="DimensionSet" field="name" value='<%=ics.GetVar("GlobalDimSet")%>' />
<dimensionset:getenableddimensions name="DimSet" list="eDims"/>

<div style="padding: 0px; margin-top: 40px; margin-left: 45px;" class="well span"><span id="LocaleList">
    <render:lookup varname="Wrapper" key="Wrapper" ttype="CSElement"  match=":x"/>
    <render:lookup varname="Layout" key="Layout" ttype="CSElement" />
    <div id="LocaleListChooser">
<%
String imgpath = request.getContextPath() + "/static/images/locale/";
imgpath = imgpath.replace("/cs/static","/static");
String selectedLocaleName = "";
String selectedLocaleDesc = "";
%>
            <ics:listloop listname="eDims">
                <ics:listget listname="eDims" fieldname="assetid" output="eDim:id"/>
                <%-- Just be safe, don't show the user dimensions that aren't locales.  The
                     Dimension Set probably won't do something silly like mix dimension subtypes
                     in the same set, but this check is inexpensive and simple --%>
                <asset:getsubtype type="Dimension" objectid='<%=ics.GetVar("eDim:id")%>' output="subtype"/>
                <ics:if condition='<%="Locale".equals(ics.GetVar("subtype"))%>'>
                    <ics:listget listname="eDims" fieldname="assetname" output="eDim:name"/>
                    <%-- load locale asset to get its description for display purposes. --%>
                    <asset:load name="myDim" type="Dimension" objectid='<%=ics.GetVar("eDim:id")%>'/>
                    <asset:get name="myDim" field="description" output="eDim:desc"/>
				    <%
                        if (ics.GetVar("eDim:id").equals(ics.GetVar("locale")))
                        {
                            selectedLocaleName = ics.GetVar("eDim:name");
                            selectedLocaleDesc = ics.GetVar("eDim:desc");
                        }
                    %>
                    <render:gettemplateurl outstr="localeurl" assembler="query"
                            ttype="CSElement" tname='<%=ics.GetVar("Layout")%>'
                            c='Page' cid='<%=ics.GetVar("HomePageId")%>'
                            wrapperpage='<%=ics.GetVar("Wrapper")%>'>
                        <render:argument name="p" value='<%=ics.GetVar("HomePageId")%>'/>
                        <render:argument name="preferred_locale" value='<%=ics.GetVar("eDim:id")%>'/>
                        <render:argument name="form-to-process" value="LocaleForm"/>
                    </render:gettemplateurl>
                    <a class="ChooserItem" href='<%=ics.GetVar("localeurl")%>' style="font:-moz-pull-down-menu;">
                        <img src='<%=imgpath + ics.GetVar("eDim:name") + ".gif"%>' alt='<%=ics.GetVar("eDim:desc")%>' style="vertical-align:baseline;" />
                        <string:stream variable="eDim:desc"/>
                    </a>&nbsp;
                </ics:if>
            </ics:listloop>
    </div>
    <%-- <img src='<%=imgpath + selectedLocaleName + ".gif"%>' title='<%=selectedLocaleDesc%>' />
    <string:stream value='<%=selectedLocaleDesc%>'/> --%>
</span></div><%-- end of LocaleList --%>

</cs:ftcs>
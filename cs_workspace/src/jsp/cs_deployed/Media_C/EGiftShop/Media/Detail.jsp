<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ taglib prefix="blobservice" uri="futuretense_cs/blobservice.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Media_C/EGiftShop/Media/Detail

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>

<assetset:setasset name="ImageSet" type='Media_C' id='<%=ics.GetVar("cid")%>' />
<assetset:getattributevalues name="ImageSet" typename='Media_A' attribute='AltText' listvarname="mediaAltList"/>
<assetset:getattributevalues name="ImageSet" typename='Media_A' attribute='ImageFile' listvarname="imageFile"/>
<assetset:getattributevalues name="ImageSet" typename='Media_A' attribute='ImageName' listvarname="imageName"/>

<ics:if condition='<%=ics.GetList("mediaAltList")!=null && ics.GetList("mediaAltList").hasData()%>'><ics:then>
      <ics:listloop listname='mediaAltList'>
	      <ics:listget listname='mediaAltList' fieldname='value' output='imgAlt' />
      </ics:listloop>
</ics:then></ics:if>

<ics:if condition='<%=ics.GetList("imageName")!=null && ics.GetList("imageName").hasData()%>'><ics:then>
      <ics:listloop listname='imageName'>
	      <ics:listget listname='imageName' fieldname='value' output='imgName' />
      </ics:listloop>
</ics:then></ics:if>

<%-- <%if(ics.GetList("imageFile") != null && ics.GetList("imageFile").hasData()){%>
	<ics:listget listname='imageFile' fieldname='value' output='mediaFile' />
<%} %>
<%if(ics.GetVar("mediaFile") != null){%>
	<blobservice:readdata id='<%=ics.GetVar("mediaFile") %>' listvarname="mediaInfo"/>
<%} %>

<%
	if (ics.GetList("mediaInfo") != null && ics.GetList("mediaInfo").hasData()) {
		ics.SetVar("mediaURL", "/"+ics.GetList("mediaInfo").getValue("urldata").replace("\\", "/"));
	}
%> --%>

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
   
  		<img src='<%= ics.GetVar("imageURL") %>' alt='<%= ics.GetVar("imgAlt") %>' title='<%= ics.GetVar("imgName") %>'>
  
      </ics:then>         
      </ics:if> 


</cs:ftcs>
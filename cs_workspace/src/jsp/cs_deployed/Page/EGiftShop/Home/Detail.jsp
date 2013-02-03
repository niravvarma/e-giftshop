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
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/EGiftShop/Home/Detail

INPUT

OUTPUT

--%>
<%-- Record dependencies for the Template --%>
<ics:if condition='<%=ics.GetVar("tid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("tid")%>' c="Template"/></ics:then></ics:if>


<assetset:setasset name="PageSet" type='Page' id='<%=ics.GetVar("cid")%>' />
<assetset:getattributevalues name="PageSet" typename='PageAttribute' attribute='PageBody' listvarname="pageBodyList"/>

<%if(ics.GetList("pageBodyList") != null && ics.GetList("pageBodyList").hasData()){%>
	<ics:listget listname='pageBodyList' fieldname='value' output='pageBody' />
<%} %>

<div class="row-fluid">
        <div class="span12">
<div class="carousel slide" id="myCarousel">
            <div class="carousel-inner">
              <div class="item active">
				<img alt="" src="/static/images/carousel_1.jpg">
                <div class="carousel-caption">
                  <h4>First Thumbnail label</h4>
                  <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                </div>

              </div>
              <div class="item">
                <img alt="" src="/static/images/carousel_2.jpg">
                <div class="carousel-caption">
                  <h4>Second Thumbnail label</h4>
                  <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                </div>
              </div>

              <div class="item">
				<img alt="" src="/static/images/carousel_3.jpg">
                <div class="carousel-caption">
                  <h4>Third Thumbnail label</h4>
                  <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                </div>
              </div>
              
              <div class="item">
				<img alt="" src="/static/images/carousel_4.jpg">
                <div class="carousel-caption">
                  <h4>Fourth Thumbnail label</h4>
                  <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                </div>
              </div>
              
            </div>

            <a data-slide="prev" href="#myCarousel" class="left carousel-control">&lsaquo;</a>
            <a data-slide="next" href="#myCarousel" class="right carousel-control">&rsaquo;</a>
</div>
        </div>
      </div>

<div class="row-fluid">
    	<div class="span12 well">
            <%=ics.GetVar("pageBody") %>
        </div>  
</div>


<div class="row-fluid">
      <div class="span12">        
        <ul class="thumbnails">
          <li class="span3">
            <div class="thumbnail">
              <div class="caption">
              	<img alt="" src="/static/images/img-1.png">
                <h5>Most</h5>
                <h3>Popular</h3>
              </div>  
              <div class="thumbnail-pad">
                  <p>Praesent vestibulum molestie lacus. Aenean noy hendrerit mauris. Phasellus porta. Fusce suscipit varius mi. </p>
                  <render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='GiftCards'/> </render:callelement><a class="btn btn_" href='<%=ics.GetVar("GiftCards")%>'>More Info</a>
              </div>
            </div>
          </li>
          <li class="span3">
            <div class="thumbnail">
              <div class="caption">
              	<img alt="" src="/static/images/img-2.png">
                <h5>Beauty</h5>
                <h3>Gifts</h3>
              </div>  
              <div class="thumbnail-pad">
                  <p>Praesent vestibulum molestie lacus. Aenean my hendrerit mauris. Phasellus porta. Fusce suscipit varius mi. </p>
                  <render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='Apparel'/> </render:callelement><a class="btn btn_" href='<%=ics.GetVar("Apparel")%>'>More Info</a>
              </div>
            </div>
          </li>
          <li class="span3">
            <div class="thumbnail">
              <div class="caption">
              	<img alt="" src="/static/images/img-3.png">
                <h5>Attention</h5>
                <h3>To Detail</h3>
              </div>  
              <div class="thumbnail-pad">
                  <p>Aenean nonummy hendrerit mauris. Phasellus porta. Fusce suipit varius mi. Cum sociis natoque penatibus et.</p>
                  <render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='Apparel'/> </render:callelement><a class="btn btn_" href='<%=ics.GetVar("Apparel")%>'>More Info</a>
              </div>
            </div>
          </li>
          <li class="span3">
            <div class="thumbnail">
              <div class="caption">
              	<img alt="" src="/static/images/img-4.png">
                <h5>Award-Winning</h5>
                <h3>Fragrances</h3>
              </div>
              <div class="thumbnail-pad">  
                  <p>Nonummy hendrerit mauris. Phasellus porta. Fusce suscipit varius mi. Cum sociis natoque penatibus et magnis.</p>
                  <render:callelement elementname="Page/Common/GetLink" scoped="global"><render:argument name="pageName" value='GiftCards'/> </render:callelement><a class="btn btn_" href='<%=ics.GetVar("GiftCards")%>'>More Info</a>
              </div>
            </div>
          </li>
        </ul>
      </div>
</div>

</cs:ftcs>
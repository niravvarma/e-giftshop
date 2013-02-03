<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Page/Common/Util

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>




	/* shortcut function to document.getElementById */
	function $(id)
	{
		return document.getElementById(id);
	}


	<%-- [KGF 2008-08-xx]
	     Additional functions for use by the redesigned locale form --%>
	/* function for showing/hiding a block element (i.e. a div)
		event = event passed from JS event callback (for mouse position)
		id = id of an element in the DOM;
		show = true for show, false for hide
	*/
	function showDiv(event, id, show)
	{
		var div = $(id);
		if (!div)
			return; //nothing to show
		div.style['display'] = (show ? 'block' : 'none');
	}

	/* function for positioning an element at or near the mouse pointer.
		event = event object passed from captured event
		id = id of an element in the DOM;
		x = x offset from mouse cursor
		y = y offset from mouse cursor (if unspecified, uses x)
	*/
	function posDivAtMouse(event, id, x, y)
	{
		if (typeof(x) == 'undefined')
			x = 0;
		if (typeof(y) == 'undefined')
			y = x;
		var div = $(id);
		if (!div)
			return; //nothing to move
		if (!(event = getEvent(event)))
			return; //can't find mouse without event info!
		div.style['position'] = 'absolute';
		div.style['left'] = (event.x ? event.x : event.pageX) + x + 'px';
		div.style['top'] = (event.y ? event.y : event.pageY) + y + 'px';
	}

	/* utility function for getting event object across browsers.
		This function simply tries falling back to window.event for IE.
		event = event object passed from an event callback.
	*/
	function getEvent(event)
	{
		if (typeof(event) == 'undefined')
			return window.event;
		return event;
	}
	
	/* utility function for getting event target across browsers. */
	function getEventTarget(event)
	{
		event = getEvent(event);
		if (!event)
			return null;
		if (event.target) //Gecko, etc.
			return event.target;
		if (event.srcElement) //IE
			return event.srcElement;
		return null; //we got nothing.
	}
	
	/* utility function for getting related event target across browsers.
		In Firefox, this is always event.relatedTarget.
		In IE, this is event.fromElement for onmouseover, and
		event.toElement for onmouseout.  However, IE sets both of these
		for both events (which is sort of logical); one will always
		match the srcElement.  Since this function is meant to be
		usable for both onmouseover and onmouseout, we will try all 3.
	*/
	function getRelatedTarget(event)
	{
		event = getEvent(event);
		if (!event)
			return null;
		var reltarget = event.relatedTarget;
		if (!reltarget && event.fromElement != getEventTarget(event))
			reltarget = event.fromElement;
		if (!reltarget)
			reltarget = event.toElement;
		return reltarget;
	}

	/* utility function to help mimic IE-only onmouseenter/leave and then some.
		event = an event captured by a JS event callback
		target = optional.  DOM element that we intended to fire the event
			(i.e. will return false if actual target != this target)
		notreltargets = optional.  For mouseover/mouseout events where we
			aren't interested in events fired related to certain elements,
			this specifies an element or an array of elements that we do
			NOT want the event coming from (mouseover) or going to (mouseout).
	*/
	function isIntendedEventTarget(event, target, notreltargets)
	{
		event = getEvent(event);
		if (!event)
			return false;
		
		//if target was provided, check that event's target matches
		if (target && target != getEventTarget(event))
			return false;
		
		if (notreltargets)
		{ //filter events fired with these related targets
			var ereltarget = getRelatedTarget(event);
			if (ereltarget)
			{ //we have a related target to compare to
				if (typeof(notreltargets.length) == 'undefined')
					return (ereltarget != notreltargets);
				//If we get here, we have an array of notreltargets.
				for (var i = 0; i < notreltargets.length; i++)
				{
					if (ereltarget == notreltargets[i])
						return false;
				}
			}
		}
		return true; //didn't hit any bail-out triggers above, we're good.
	}
	
	/* returns an array of all of p's children (recursively, depth-first).
		This is used for passing as notreltargets for some events.
	*/
	function getAllChildren(p) {
		var children = [];
		for (var i = 0; i < p.childNodes.length; i++) {
			children.push(p.childNodes[i]);
			children = children.concat(getAllChildren(p.childNodes[i]));
		}
		return children;
	}

</cs:ftcs>
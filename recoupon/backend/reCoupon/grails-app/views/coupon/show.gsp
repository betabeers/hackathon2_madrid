
<%@ page import="betabeers.hackaton.Coupon" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'coupon.label', default: 'Coupon')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-coupon" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-coupon" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>

			<g:form class="associateTagForm" action="associateTag">
					<g:hiddenField name="id" value="${couponInstance.id}"/>
					<label for="tagId">TagID</label>
					<g:textField name="tagID" value=""/>
					<g:submitButton name="create" class="associateTag" value="Associate a Tag to a Coupon" />
			</g:form>

			<g:each in="${couponInstance.tags}" status="i" var="tagInstance">
				<span class="tag">${tagInstance.tagID}</span>
			</g:each>

			<ul>

			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

			<g:if test="${scans}">
			<h3 style="clear: both;">Scaneados</h3>
			<g:each in="${scans}" status="i" var="scan">
				<g:if test="${couponInstance.requiredScans == scan.counter}"><li class="green scan"></g:if><g:else><li class="scan"></g:else>${scans.user.username}: ${scan.counter} código: ${scan.id}<br/> <qrcode:image text="${scan.id}"  width="128" height="128" /></li>
			</g:each>
			</ul>
			</g:if>

			<g:if test="${couponInstance?.description}">
				<div class="description">
					<g:if test="${couponInstance?.image}"><img style="float: right;" src="${couponInstance.image}" alt=""/></g:if>
					${couponInstance.description}</div>
			</g:if>

			<ol class="property-list coupon">
				<g:if test="${couponInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="coupon.address.label" default="Address" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${couponInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.bussiness}">
				<li class="fieldcontain">
					<span id="bussiness-label" class="property-label"><g:message code="coupon.bussiness.label" default="Bussiness" /></span>
					
						<span class="property-value" aria-labelledby="bussiness-label"><g:fieldValue bean="${couponInstance}" field="bussiness"/></span>
					
				</li>
				</g:if>
			
			
				<g:if test="${couponInstance?.city}">
				<li class="fieldcontain">
					<span id="city-label" class="property-label"><g:message code="coupon.city.label" default="City" /></span>
					
						<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${couponInstance}" field="city"/></span>
					
				</li>
				</g:if>
			
				
				
				<g:if test="${couponInstance?.discount}">
				<li class="fieldcontain">
					<span id="discount-label" class="property-label"><g:message code="coupon.discount.label" default="Discount" /></span>
					
						<span class="property-value" aria-labelledby="discount-label"><g:fieldValue bean="${couponInstance}" field="discount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.endDate}">
				<li class="fieldcontain">
					<span id="endDate-label" class="property-label"><g:message code="coupon.endDate.label" default="End Date" /></span>
					
						<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${couponInstance?.endDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.favicon}">
				<li class="fieldcontain">
					<span id="favicon-label" class="property-label"><g:message code="coupon.favicon.label" default="Favicon" /></span>
					
						<span class="property-value" aria-labelledby="favicon-label"><g:fieldValue bean="${couponInstance}" field="favicon"/></span>
					
				</li>
				</g:if>
			
				
				
			
				<g:if test="${couponInstance?.keywords}">
				<li class="fieldcontain">
					<span id="keywords-label" class="property-label"><g:message code="coupon.keywords.label" default="Keywords" /></span>
					
						<span class="property-value" aria-labelledby="keywords-label"><g:fieldValue bean="${couponInstance}" field="keywords"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label"><g:message code="coupon.latitude.label" default="Latitude" /></span>
					
						<span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${couponInstance}" field="latitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label"><g:message code="coupon.longitude.label" default="Longitude" /></span>
					
						<span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${couponInstance}" field="longitude"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="coupon.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${couponInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.originalPrice}">
				<li class="fieldcontain">
					<span id="originalPrice-label" class="property-label"><g:message code="coupon.originalPrice.label" default="Original Price" /></span>
					
						<span class="property-value" aria-labelledby="originalPrice-label"><g:fieldValue bean="${couponInstance}" field="originalPrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.partner}">
				<li class="fieldcontain">
					<span id="partner-label" class="property-label"><g:message code="coupon.partner.label" default="Partner" /></span>
					
						<span class="property-value" aria-labelledby="partner-label"><g:fieldValue bean="${couponInstance}" field="partner"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.phone}">
				<li class="fieldcontain">
					<span id="phone-label" class="property-label"><g:message code="coupon.phone.label" default="Phone" /></span>
					
						<span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${couponInstance}" field="phone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="coupon.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${couponInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.publishDate}">
				<li class="fieldcontain">
					<span id="publishDate-label" class="property-label"><g:message code="coupon.publishDate.label" default="Publish Date" /></span>
					
						<span class="property-value" aria-labelledby="publishDate-label"><g:formatDate date="${couponInstance?.publishDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="property-label"><g:message code="coupon.startDate.label" default="Start Date" /></span>
					
						<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${couponInstance?.startDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="coupon.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${couponInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.valid_date}">
				<li class="fieldcontain">
					<span id="valid_date-label" class="property-label"><g:message code="coupon.valid_date.label" default="Validdate" /></span>
					
						<span class="property-value" aria-labelledby="valid_date-label"><g:formatDate date="${couponInstance?.valid_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.yunaitID}">
				<li class="fieldcontain">
					<span id="yunaitID-label" class="property-label"><g:message code="coupon.yunaitID.label" default="Yunait ID" /></span>
					
						<span class="property-value" aria-labelledby="yunaitID-label"><g:fieldValue bean="${couponInstance}" field="yunaitID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${couponInstance?.yunaitURL}">
				<li class="fieldcontain">
					<span id="yunaitURL-label" class="property-label"><g:message code="coupon.yunaitURL.label" default="Yunait URL" /></span>
					
						<span class="property-value" aria-labelledby="yunaitURL-label"><g:fieldValue bean="${couponInstance}" field="yunaitURL"/></span>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${couponInstance?.id}" />
					<g:link class="edit" action="edit" id="${couponInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>


<%@ page import="betabeers.hackaton.Coupon" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'coupon.label', default: 'Coupon')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-coupon" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="http://195.235.111.101:8080/reCoupon/coupon/list"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li>
				<li><a class="home" href="/reCoupon/coupon/list?bussiness=Arteria%20Coliseum">Las ofertas de Arteria Coliseum</a></li>

			</ul>
		</div>
		<div id="list-coupon" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:each in="${couponInstanceList}" status="i" var="couponInstance">
			<div class="offer">
				<g:link action="show" id="${couponInstance.id}">
				<h4><span class="oldprice">${couponInstance.originalPrice}</span>, ${couponInstance.price}</h4>
				<p>${couponInstance.title}</p>
				
				<img src="${couponInstance.image}" alt="${couponInstance.name}" />
				</g:link>
			</div>
			</g:each>
			<div class="pagination">
				<g:paginate total="${couponInstanceTotal}" />
			</div>
		</div>
	</body>
</html>

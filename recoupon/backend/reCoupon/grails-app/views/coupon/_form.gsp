<%@ page import="betabeers.hackaton.Coupon" %>


<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'requiredScans', 'error')} ">
	<label for="requiredScans">
		<g:message code="coupon.requiredScans.label" default="RequiredScans" />
		
	</label>
	<g:textField name="requiredScans" value="${couponInstance?.requiredScans}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="coupon.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${couponInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'bussiness', 'error')} ">
	<label for="bussiness">
		<g:message code="coupon.bussiness.label" default="Bussiness" />
		
	</label>
	<g:textField name="bussiness" value="${couponInstance?.bussiness}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'categoryId', 'error')} required">
	<label for="categoryId">
		<g:message code="coupon.categoryId.label" default="Category Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="categoryId" required="" value="${couponInstance.categoryId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'city', 'error')} ">
	<label for="city">
		<g:message code="coupon.city.label" default="City" />
		
	</label>
	<g:textField name="city" value="${couponInstance?.city}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="coupon.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${couponInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'discount', 'error')} required">
	<label for="discount">
		<g:message code="coupon.discount.label" default="Discount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="discount" step="any" required="" value="${couponInstance.discount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="coupon.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day"  value="${couponInstance?.endDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'favicon', 'error')} ">
	<label for="favicon">
		<g:message code="coupon.favicon.label" default="Favicon" />
		
	</label>
	<g:textField name="favicon" value="${couponInstance?.favicon}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'image', 'error')} ">
	<label for="image">
		<g:message code="coupon.image.label" default="Image" />
		
	</label>
	<g:textField name="image" value="${couponInstance?.image}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'keywords', 'error')} ">
	<label for="keywords">
		<g:message code="coupon.keywords.label" default="Keywords" />
		
	</label>
	<g:textField name="keywords" value="${couponInstance?.keywords}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="coupon.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="latitude" step="any" required="" value="${couponInstance.latitude}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="coupon.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="longitude" step="any" required="" value="${couponInstance.longitude}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="coupon.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${couponInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'originalPrice', 'error')} required">
	<label for="originalPrice">
		<g:message code="coupon.originalPrice.label" default="Original Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="originalPrice" step="any" required="" value="${couponInstance.originalPrice}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'partner', 'error')} ">
	<label for="partner">
		<g:message code="coupon.partner.label" default="Partner" />
		
	</label>
	<g:textField name="partner" value="${couponInstance?.partner}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'phone', 'error')} ">
	<label for="phone">
		<g:message code="coupon.phone.label" default="Phone" />
		
	</label>
	<g:textField name="phone" value="${couponInstance?.phone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="coupon.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="price" step="any" required="" value="${couponInstance.price}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'publishDate', 'error')} required">
	<label for="publishDate">
		<g:message code="coupon.publishDate.label" default="Publish Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="publishDate" precision="day"  value="${couponInstance?.publishDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="coupon.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${couponInstance?.startDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="coupon.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${couponInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'valid_date', 'error')} required">
	<label for="valid_date">
		<g:message code="coupon.valid_date.label" default="Validdate" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="valid_date" precision="day"  value="${couponInstance?.valid_date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'yunaitID', 'error')} ">
	<label for="yunaitID">
		<g:message code="coupon.yunaitID.label" default="Yunait ID" />
		
	</label>
	<g:textField name="yunaitID" value="${couponInstance?.yunaitID}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: couponInstance, field: 'yunaitURL', 'error')} ">
	<label for="yunaitURL">
		<g:message code="coupon.yunaitURL.label" default="Yunait URL" />
		
	</label>
	<g:textField name="yunaitURL" value="${couponInstance?.yunaitURL}"/>
</div>


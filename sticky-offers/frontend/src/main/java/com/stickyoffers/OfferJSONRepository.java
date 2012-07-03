package com.stickyoffers;

import org.springframework.http.*;
import org.springframework.http.converter.json.GsonHttpMessageConverter;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import roboguice.inject.InjectResource;

public class OfferJSONRepository implements OfferRepository {
    private static final String CLAIM_URL = "/claim";

    @InjectResource(R.string.baseUrl)
    private String baseUrl;

    @Override
    public Offer claim(String token) {
        RestTemplate restTemplate = new RestTemplate(true);
        GsonHttpMessageConverter messageConverter = new GsonHttpMessageConverter();
        restTemplate.getMessageConverters().add(messageConverter);
        ResponseEntity<Offer> response =
            restTemplate.exchange(fullUrl(CLAIM_URL), HttpMethod.POST, claimRequestWith(token), Offer.class);
        return response.getBody();
    }

    private HttpEntity<MultiValueMap<String, Object>> claimRequestWith(String token) {
        return new HttpEntity<MultiValueMap<String, Object>>(requestParamsForClaim(token), formDataHeaders());
    }

    private MultiValueMap<String, Object> requestParamsForClaim(String token) {
        MultiValueMap<String, Object> requestParams = new LinkedMultiValueMap<String, Object>();
        requestParams.add("token", token);
        return requestParams;
    }

    private HttpHeaders formDataHeaders() {
        HttpHeaders requestHeaders = new HttpHeaders();
        requestHeaders.setContentType(MediaType.MULTIPART_FORM_DATA);
        return requestHeaders;
    }

    private String fullUrl(String url) {
        return baseUrl + url;
    }
}

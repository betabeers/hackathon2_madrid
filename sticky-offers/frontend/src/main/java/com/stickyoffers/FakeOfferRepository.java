package com.stickyoffers;

import com.google.inject.Singleton;

@Singleton
public class FakeOfferRepository implements OfferRepository {
    @Override
    public Offer claim(String token) {
        Offer offer = new Offer();
        offer.setDiscountCode("PROMO1");
        return offer;
    }
}

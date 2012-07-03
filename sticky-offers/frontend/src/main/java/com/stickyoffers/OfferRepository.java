package com.stickyoffers;

public interface OfferRepository {
    public Offer claim(String token);
}

package com.stickyoffers;

import com.google.inject.AbstractModule;

public class Module extends AbstractModule {
    @Override
    protected void configure() {
        bind(OfferRepository.class).to(OfferJSONRepository.class);
    }
}

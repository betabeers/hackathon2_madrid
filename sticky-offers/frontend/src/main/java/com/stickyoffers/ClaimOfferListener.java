package com.stickyoffers;

public interface ClaimOfferListener {
    void claimingOffer();

    void offerAssigned(Offer offer);

    void claimOfferError();

    void claimOfferAborted();
}

package com.stickyoffers;

import android.content.Context;
import com.google.inject.Inject;
import roboguice.activity.event.OnStopEvent;
import roboguice.event.EventListener;
import roboguice.event.EventManager;
import roboguice.util.Ln;
import roboguice.util.RoboAsyncTask;

public class ClaimOfferTask extends RoboAsyncTask<Offer> implements EventListener {
    @Inject
    private OfferRepository repository;
    @Inject
    private EventManager eventManager;

    private ClaimOfferListener claimOfferListener;
    private String token;

    public void setClaimOfferListener(ClaimOfferListener claimOfferListener) {
        this.claimOfferListener = claimOfferListener;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Inject
    public ClaimOfferTask(Context context) {
        super(context);
        eventManager.registerObserver(OnStopEvent.class, this);
    }

    @Override
    protected void onPreExecute() {
        claimOfferListener.claimingOffer();
    }

    public Offer call() throws Exception {
        return repository.claim(token);
    }

    @Override
    protected void onSuccess(Offer offer) throws Exception {
        claimOfferListener.offerAssigned(offer);
    }

    @Override
    protected void onException(Exception e) throws RuntimeException {
        Ln.e(e);
        claimOfferListener.claimOfferError();
    }

    @Override
    public void onEvent(Object event) {
        if (event instanceof OnStopEvent) {
            if (claimOfferListener != null) {
                claimOfferListener.claimOfferAborted();
            }
        }
    }
}

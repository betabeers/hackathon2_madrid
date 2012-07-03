package com.stickyoffers;

import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import com.google.inject.Inject;
import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;
import roboguice.activity.RoboActivity;
import roboguice.inject.InjectResource;
import roboguice.inject.InjectView;

import static android.app.ProgressDialog.STYLE_SPINNER;
import static com.google.zxing.integration.android.IntentIntegrator.QR_CODE_TYPES;


public class MainActivity extends RoboActivity implements ClaimOfferListener {
    private static final int LOAD_PROGRESS_DIALOG = 0;

    @InjectView(R.id.main)
    private LinearLayout main;
    @InjectView(R.id.scan)
    private Button scan;
    @InjectView(R.id.discountCode)
    private TextView discountCode;
    @InjectResource(R.string.claiming)
    private String claiming;
    @InjectResource(R.string.claimOfferError)
    private String claimOfferError;
    @Inject
    private ClaimOfferTask claimOfferTask;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        scan.setOnClickListener(new ScanOnClickListener());
    }

    private class ScanOnClickListener implements View.OnClickListener {
        @Override
        public void onClick(View v) {
            startQRBarcodeScan();
        }

        private void startQRBarcodeScan() {
            IntentIntegrator integrator = new IntentIntegrator(MainActivity.this);
            integrator.initiateScan(QR_CODE_TYPES);
        }
    }

    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        IntentResult scanResult = IntentIntegrator.parseActivityResult(requestCode, resultCode, intent);
        String token = scanResult.getContents();
        if (token != null) {
            claimOffer(scanResult.getContents());
        }
    }

    private void claimOffer(String token) {
        claimOfferTask.setClaimOfferListener(this);
        claimOfferTask.setToken(token);
        claimOfferTask.execute();
    }

    @Override
    protected Dialog onCreateDialog(int id) {
        if (id == LOAD_PROGRESS_DIALOG) {
            return createClaimingProgressDialog();
        }

        return super.onCreateDialog(id);
    }

    private Dialog createClaimingProgressDialog() {
        ProgressDialog progressDialog = new ProgressDialog(this);
        progressDialog.setProgressStyle(STYLE_SPINNER);
        progressDialog.setMessage(claiming);
        return progressDialog;
    }

    @Override
    public void claimingOffer() {
        showDialog(LOAD_PROGRESS_DIALOG);
    }

    @Override
    public void offerAssigned(Offer offer) {
        removeDialog(LOAD_PROGRESS_DIALOG);
        discountCode.setText("Discount code\n" + offer.getDiscountCode());
    }

    @Override
    public void claimOfferError() {
        removeDialog(LOAD_PROGRESS_DIALOG);
        Toast.makeText(this, claimOfferError, Toast.LENGTH_LONG).show();
    }

    @Override
    public void claimOfferAborted() {
        removeDialog(LOAD_PROGRESS_DIALOG);
    }
}
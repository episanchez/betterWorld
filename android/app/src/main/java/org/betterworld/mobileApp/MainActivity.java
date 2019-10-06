package org.betterworld.mobileApp;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import com.stripe.android.exception.StripeException;
import com.stripe.android.model.Card;
import com.stripe.android.Stripe;
import com.stripe.android.model.Token;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String PAYMENT_CHANNEL = "betterWorld.org/payment";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Context context = this.registrarFor("plugin-main").activeContext();

    new MethodChannel(getFlutterView(), PAYMENT_CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                if (call.method.equals("addSource")) {
                  String number= call.argument("number");
                  String cvc = call.argument("cvc");
                  String exp = call.argument("exp");

                  Stripe stripe = new Stripe(context, "pk_test_7xNL5PBZXOfoHldBs6Orrf35");
                  Card card = new Card(number,
                          Integer.parseInt(exp.split("/")[0]),
                          Integer.parseInt(exp.split("/")[1]),
                          cvc);
                  if (card.validateCard()){
                    try {
                      Token token = stripe.createTokenSynchronous(card);
                      result.success(token);
                    } catch (StripeException stripeEx) {
                      String errorMessage = stripeEx.getLocalizedMessage();
                      result.error("400", errorMessage, stripeEx);
                    }
                  } else result.error("400", "Card is not valid", null);
                } else if (call.method.equals("paymentIntent")) {
                  result.notImplemented();
                } else {
                  result.notImplemented();
                }
              }
            }
    );
  }
}

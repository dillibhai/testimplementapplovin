package com.example.package_f_version3
import NativeViewAppLovin
import android.content.Context
import android.os.Bundle
import com.applovin.sdk.AppLovinSdk
import com.facebook.ads.AudienceNetworkAds
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import np.com.nepalipatro.NativeAdWrapper

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        AudienceNetworkAds.initialize(context)
        initializeApplovinSdk()
        appLovinNativeAdDisplay()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val factory = NativeAdWrapper(layoutInflater, context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "NpNativeAd", factory)

    }
    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "NpNativeAd")
    }

    private fun initializeApplovinSdk (){
        AppLovinSdk.getInstance( context ).mediationProvider = "max"
        AppLovinSdk.getInstance( context ).initializeSdk{
        }

    }
    private fun appLovinNativeAdDisplay(){
        flutterEngine?.platformViewsController?.registry?.registerViewFactory("<platform-view-type>", NativeViewFactory())
    }
}
class NativeViewFactory: PlatformViewFactory(StandardMessageCodec.INSTANCE){
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParam=args as Map<String?, Any?>?
        return  NativeViewAppLovin( context!!, viewId, creationParam)
    }
}

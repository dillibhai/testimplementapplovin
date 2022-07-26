package np.com.nepalipatro
import NativeViewAppLovin
import android.content.Context
import android.os.Bundle
import com.applovin.sdk.AppLovinSdk
import com.applovin.sdk.AppLovinSdkConfiguration
import com.facebook.ads.AudienceNetworkAds
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        AudienceNetworkAds.initialize(this);
        initializeApplovinSdk()
        appLovinnativeAdDisplay()
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
        AppLovinSdk.getInstance( context ).setMediationProvider( "max" )
        AppLovinSdk.getInstance( context ).initializeSdk({ configuration: AppLovinSdkConfiguration ->
        }
        )
    }
    private fun appLovinnativeAdDisplay(){
        flutterEngine?.platformViewsController?.registry?.registerViewFactory("<platform-view-type>", NativeViewFactory())
    }
}
class NativeViewFactory: PlatformViewFactory(StandardMessageCodec.INSTANCE){
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationparam=args as Map<String?, Any?>?
        return NativeViewAppLovin(context!!, viewId, creationparam)
    }
}

package np.com.nepalipatro

import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory


class NativeAdWrapper(private val layoutInflater: LayoutInflater, private val context: Context,) :
    NativeAdFactory {
    init {
        Log.d("DilliBhandari", "Init")
   //    createNativeAd(nativeAd =  creationParams);
    }

    override fun createNativeAd(
        nativeAd: NativeAd?,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val layout = customOptions!!["layout"] as String
        val layoutRes:Int = context.resources.getIdentifier(layout, "layout", "np.com.nepalipatro")
        val adView = layoutInflater.inflate(layoutRes, null) as NativeAdView
        val headlineView = adView.findViewById<TextView>(R.id.google_flutter_native_ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.google_flutter_native_ad_body)
        val  adAttributionView = adView.findViewById<TextView>(R.id.google_flutter_native_ad_attribution)
        val advertiserView = adView.findViewById<TextView>(R.id.google_flutter_native_ad_advertiser)
        val   mediaView:MediaView? = adView.findViewById(R.id.google_flutter_native_ad_media)
        val   button = adView.findViewById<Button>(R.id.google_flutter_native_ad_call_to_action)
        val  imageView:ImageView? = adView.findViewById(R.id.google_flutter_native_ad_icon)
        if (nativeAd == null) {
            return adView
        }
        headlineView.text = nativeAd.headline

        bodyView.text = nativeAd.body
        adAttributionView.text = "Ad"
        advertiserView.text = nativeAd.advertiser
        nativeAd.mediaContent?.let { mediaView?.setMediaContent(it) }
        if (nativeAd.mediaContent?.hasVideoContent()==true)
            mediaView?.setImageScaleType(ImageView.ScaleType.CENTER_CROP)
        mediaView?.setOnHierarchyChangeListener(object : ViewGroup.OnHierarchyChangeListener {
            override fun onChildViewAdded(parent: View?, child: View) {
                if (child is ImageView) {
                    val imageView = child
                    imageView.adjustViewBounds = true
                    var bitMapImage: Bitmap = (nativeAd?.mediaContent?.mainImage as BitmapDrawable).bitmap
                    imageView.setImageBitmap(bitMapImage)
                }
            }
            override fun onChildViewRemoved(parent: View?, child: View?) {}
        })
        imageView?.setImageDrawable(nativeAd?.icon?.drawable)
        button.text = nativeAd?.callToAction
        adView.mediaView = mediaView;
        adView.setNativeAd(nativeAd!!)
        adView.bodyView = bodyView
        adView.headlineView = headlineView
        return adView
    }

}
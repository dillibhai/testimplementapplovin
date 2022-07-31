import Flutter
import UIKit
import AppLovinSDK

class NativeViewAppLovinFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeViewAppLovin(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class NativeViewAppLovin: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var nativeAdLoader: MANativeAdLoader?
    private var loadedNativeAd: MAAd?
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeAdLoader()
        loadNativeAd()
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeAdView() -> MANativeAdView? {
        let nativeAdViewNib = UINib(nibName: "NativeCustomAdView", bundle: Bundle.main)
        let nativeAdView = nativeAdViewNib.instantiate(withOwner: nil, options: nil).first! as! MANativeAdView?
        
        let adViewBinder = MANativeAdViewBinder.init(builderBlock: { (builder) in
            builder.titleLabelTag = 1;
            builder.bodyLabelTag = 2;
            builder.callToActionButtonTag = 3;
            builder.iconImageViewTag = 4;
            builder.mediaContentViewTag = 5;
            builder.advertiserLabelTag = 6;
            builder.optionsContentViewTag = 7;
        })
        nativeAdView?.bindViews(with: adViewBinder)
        return nativeAdView
    }
    
    func createNativeAdLoader()
    {
        nativeAdLoader = MANativeAdLoader(adUnitIdentifier: "YOUR_AD_UNIT_ID")
        nativeAdLoader?.nativeAdDelegate = self;
        nativeAdLoader?.revenueDelegate = self;
    }
    
    func loadNativeAd()
    {
        nativeAdLoader?.loadAd(into: createNativeAdView());
    }
}

extension NativeViewAppLovin: MANativeAdDelegate
{
    func didLoadNativeAd(_ nativeAdView: MANativeAdView?, for ad: MAAd) {
        if let nativeAd = loadedNativeAd
        {
            nativeAdLoader?.destroy(nativeAd)
        }
        
        loadedNativeAd = ad;
        
        // Set to false if modifying constraints after adding the ad view to your layout
        _view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the native ad view to your layout
        guard let nativeAdView = nativeAdView else { return }
        _view.addSubview(nativeAdView)
        
        // Set ad view to span width and height of container and center the ad
        _view.addConstraint(NSLayoutConstraint(item: nativeAdView, attribute: .width, relatedBy: .equal, toItem: _view, attribute: .width, multiplier: 1, constant: 0))
        _view.addConstraint(NSLayoutConstraint(item: nativeAdView, attribute: .height, relatedBy: .equal, toItem: _view, attribute: .height, multiplier: 1, constant: 0))
        _view.addConstraint(NSLayoutConstraint(item: nativeAdView, attribute: .centerX, relatedBy: .equal, toItem: _view, attribute: .centerX, multiplier: 1, constant: 0))
        _view.addConstraint(NSLayoutConstraint(item: nativeAdView, attribute: .centerY, relatedBy: .equal, toItem: _view, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError)
    {
        // Native ad load failed
        // We recommend retrying with exponentially higher delays up to a maximum delay
    }
    
    func didClickNativeAd(_ ad: MAAd) { }
}

extension NativeViewAppLovin: MAAdRevenueDelegate {
    func didPayRevenue(for ad: MAAd) { }
}

class FLPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = NativeViewAppLovinFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "<platform-view-type>")
    }
}

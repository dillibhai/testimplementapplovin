import UIKit
import Flutter
import GoogleMobileAds
import AdSupport
import AppLovinSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["cdc6e683e056e005497720906cc48dda"]
        
        self.initializeAppLovin()
        
        self.nativeAdPluginSetup()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func initializeAppLovin() {
        // Please make sure to set the mediation provider value to "max" to ensure proper functionality
        ALSdk.shared()!.mediationProvider = "max"
        
        ALSdk.shared()!.userIdentifier = "C36CFE3E-51FA-44B4-B6EC-F946BC8E314A"
        
        ALSdk.shared()!.initializeSdk { (configuration: ALSdkConfiguration) in
            // Start loading ads
        }
    }
    
    func nativeAdPluginSetup() {
        weak var registrar = self.registrar(forPlugin: "FLPlugin")
        
        let factory = NativeViewAppLovinFactory(messenger: registrar!.messenger())
        self.registrar(forPlugin: "<FLPlugin>")!.register(
            factory,
            withId: "<platform-view-type>")
    }
}

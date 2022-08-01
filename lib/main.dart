import 'package:ad_package/ads/interstital_ad_wrapper.dart';
import 'package:ad_package/ads/rewarded_ad_wrapper.dart';
import 'package:ad_package/widget/banner_ad_widget.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:flutter/material.dart';
import 'package:package_f_version3/adsview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseRemoteConfig.instance;
  // FirebaseApp app = await Firebase.initializeApp();
  // print(app);
  FacebookAudienceNetwork.init(
      iOSAdvertiserTrackingEnabled: false,
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6");
  // testingId: "3114f388-d9b0-4c03-9b16-7edf841f67f5");

  // final remoteConfig = FirebaseRemoteConfig.instance;
  // remoteConfig.setConfigSettings(
  //   RemoteConfigSettings(
  //     fetchTimeout: const Duration(minutes: 1),
  //     minimumFetchInterval: const Duration(hours: 1),
  //   ),
  // );

  // AdSettings.addTestDevice("3114f388-d9b0-4c03-9b16-7edf841f67f5");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late final FirebaseRemoteConfig remoteconfig;
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage()
        // home: FutureBuilder<FirebaseRemoteConfig>(
        //   future: setupRemoteConfig(),
        //   builder: (BuildContext context,
        //       AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
        //     return snapshot.hasData
        //         ? MyHomePage(
        //             remoteConfig: snapshot.requireData,
        //           )
        //         : Scaffold(
        //             appBar: AppBar(
        //               title: const Text("Data Not found"),
        //             ),
        //             body: const Center(
        //               child: Text("data not avialable..."),
        //             ),
        //           );
        //   },
        // ),
        );
  }
}

Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  // await Firebase.initializeApp();
  await remoteConfig.ensureInitialized();
  await remoteConfig.fetch();
  await remoteConfig.activate();
  // await remoteCOnfig.fetchAndActivate();
  return remoteConfig;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements RewardedAdListener {
  // RewardedAdListener {

  // }
  RewardedAdWrapper? reward;
  @override
  void initState() {
    reward = RewardedAdWrapper(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Package ad"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AdsView()
                          // builder: (context) => AdsView(
                          //   // adportal: widget.remoteConfig.getInt("adPortal"),
                          // ),
                          ),
                    );
                  },
                  child: const Text("Ad test Btn")),
              ElevatedButton(
                onPressed: () {
                  InterstitialAdWrapper(
                      "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
                      adsPortal: 1);
                },
                child: const Text("interstitalAd"),
              ),
              ElevatedButton(
                onPressed: () {
                  // RewardedAdWrapper(this);
                  RewardedAdWrapper(
                    this,
                    adsPortal: 1,
                  );
                },
                child: const Text("Rewarded"),
              ),
              ElevatedButton(
                onPressed: (() {
                  BannerAdWidget(
                    "",
                    "",
                    adsPortal: 1,
                  );
                }),
                child: const Text("Banner"),
              )

              // ElevatedButton(
              //     onPressed: () {
              //       setState(() {
              //         nativeAd = FacebookNativeAd(
              //           adType: NativeAdType.NATIVE_AD_VERTICAL,
              //           placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
              //           height: 325,
              //           backgroundColor: Colors.amber,
              //           width: double.infinity,
              //         );
              //       });
              //     },
              //     child: Text("fb native")),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).push(
              //           MaterialPageRoute(builder: (context) => NewsView()));
              //     },
              //     child: const Text("News Package Btn")),
              // NativeAdWidget(
              //     "",
              //     "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
              //     "google_native_ad",
              //     adsPortal: 2,
              //     325)
            ],
          ),
        ));
  }

  @override
  onUserNotRewarded() {
    // TODO: implement onUserNotRewarded
    throw UnimplementedError();
  }

  @override
  onUserRewarded() {
    // TODO: implement onUserRewarded
    throw UnimplementedError();
  }
}

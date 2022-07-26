// // ignore_for_file: non_constant_identifier_names, prefer_const_declarations

// import 'dart:io';

// import 'package:facebook_audience_network/constants.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';

// final String REMOTE_CONFIG_BANNER_AD = "REMOTE_CONFIG_BANNER_AD";
// final String DEFAULT_REMOTE_CONFIG_BANNER_AD = "REMOTE_CONFIG_BANNER_AD";
// final String IOS_REMOTE_CONFIG_BANNER_AD = "REMOTE_CONFIG_BANNER_AD";

// class RemoteConfigSetup {
//   RemoteConfig? remoteConfig;
//   Future<void> initializeConfig() async {
//     await initRemoteConfigs();
//     await fetchRemoteConfig();
//   }

//   initRemoteConfigs() async {
//     try {
//       try {
//         await remoteConfig?.fetchAndActivate();
//       } catch (e) {
//         print(e);
//       }
//       await remoteConfig?.setDefaults(<String, dynamic>{
//         REMOTE_CONFIG_BANNER_AD: DEFAULT_REMOTE_CONFIG_BANNER_AD,
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<bool> fetchRemoteConfig() async {
//     var showBannerAds = 0;
//     try {
//       if (Platform.isAndroid) {
//         showBannerAds = remoteConfig!.getBool(REMOTE_CONFIG_BANNER_AD) ? 1 : 0;
//       } else if (Platform.isIOS) {
//         showBannerAds = remoteConfig!.getInt(IOS_REMOTE_CONFIG_BANNER_AD);
//       }
//     } catch (e) {
//       return false;
//     }

//     return false;
//   }
// }

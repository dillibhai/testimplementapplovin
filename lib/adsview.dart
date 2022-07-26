import 'package:ad_package/utils/enums.dart';
import 'package:ad_package/widget/banner_ad_widget.dart';
import 'package:ad_package/widget/native_ad_widget.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class AdsView extends StatefulWidget {
  const AdsView({Key? key, required this.adportal}) : super(key: key);
  final int? adportal;
  @override
  State<AdsView> createState() => _AdsViewState();
}

class _AdsViewState extends State<AdsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ad package v3"),
      ),
      body: ListView(
        children: [
          // NativeAdWidget(
          //     "",
          //     "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
          //     // "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
          //     // "radio_layout_native_news",
          //     "",
          //     // adsPortal: widget.adportal!.toInt(),
          //     adsPortal: 1,
          //     priority: AdsPriority.Other,
          //     325),

          // NativeAdWidget(
          //     "",
          //     "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
          //     "",
          //     adsPortal: 3,
          //     325),

          NativeAdWidget(
              "",
              "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
              // "google_native_ad",
              "google_native_ad",
              adsPortal: 3,
              325),
          // NativeAdWidget(
          //     "",
          //     "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
          //     // "google_native_ad",
          //     "radio_native_ad_view",
          //     adsPortal: 1,
          //     325),
          // BannerAdWidget(
          //   "",
          //   "923d5177404a64a3",
          //   adsPortal: 3,
          // ),
          // NativeAdWidget(
          //     "",
          //     "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
          //     "google_native_ad",
          //     adsPortal: 2,
          //     125),

          // const SizedBox(height: 10),
          // BannerAdWidget(
          //   "",
          //   "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047",
          //   adsPortal: 1,
          // )
        ],
      ),
      // bottomNavigationBar: BannerAdWidget(
      //     priority: AdsPriority.Other, adsPortal: 3, "", "923d5177404a64a3"),

      // bottomNavigationBar: BannerAdWidget(
      //   adsPortal: 1,
      //   "1",
      //   "ca-app-pub-3940256099942544/6300978111",
      // ),
    );
  }
}

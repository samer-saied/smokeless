// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'ad_helper.dart';

// class AddBannerWidget extends StatefulWidget {
//   const AddBannerWidget({Key? key}) : super(key: key);

//   @override
//   State<AddBannerWidget> createState() => _AddBannerWidgetState();
// }

// class _AddBannerWidgetState extends State<AddBannerWidget> {
//   ///
//   ///
//   ///
//   late BannerAd _bannerAd;
//   bool _isBannerAdReady = false;
//   final AdSize _adSize = AdSize.banner;

//   @override
//   void initState() {
//     _bannerAd = BannerAd(
//       adUnitId: AdHelper.interstitialAdUnitId,
//       request: const AdRequest(),
//       size: _adSize,
//       listener: BannerAdListener(
//         onAdLoaded: (_) {
//           setState(() {
//             _isBannerAdReady = true;
//           });
//         },
//         onAdFailedToLoad: (ad, err) {
//           log('Failed to load a banner ad: ${err.message}');
//           _isBannerAdReady = false;
//           ad.dispose();
//         },
//       ),
//     );

//     _bannerAd.load();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _bannerAd.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: _adSize.height.toDouble(),
//         width: _adSize.width.toDouble(),
//         child: (_isBannerAdReady)
//             ? Align(
//                 alignment: Alignment.topCenter,
//                 child: SizedBox(
//                   width: _bannerAd.size.width.toDouble(),
//                   height: _bannerAd.size.height.toDouble(),
//                   child: AdWidget(ad: _bannerAd),
//                 ),
//               )
//             : const SizedBox());
//   }
// }

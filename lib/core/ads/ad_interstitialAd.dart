// import 'package:flutter/material.dart';
// import 'package:freesmoking/screens/home/home_screen.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// import '../../screens/main_page_screen.dart';
// import 'ad_helper.dart';

// class InterstitialAdWidget2 extends StatefulWidget {
//   const InterstitialAdWidget({Key? key}) : super(key: key);

//   @override
//   State<InterstitialAdWidget> createState() => _InterstitialAdWidgetState();
// }

// class _InterstitialAdWidgetState extends State<InterstitialAdWidget> {
//   InterstitialAd? _interstitialAd;
//   bool _isInterstitialAdReady = false;

//   void _createInterstitialAd() {
//     InterstitialAd.load(
//       adUnitId: AdHelper.interstitialAdUnitId,
//       request: AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) {
//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (ad) {
//               MainPageScreen();
//             },
//           );

//           setState(() {
//             _interstitialAd = ad;
//           });
//         },
//         onAdFailedToLoad: (err) {
//           print('Failed to load an interstitial ad: ${err.message}');
//           _isInterstitialAdReady = false;
//         },
//       ),
//     );
//   }

//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }

//   @override
//   void dispose() {
//     _interstitialAd?.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MainPageScreen();
//   }
// }

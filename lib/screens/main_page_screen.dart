import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

// import '../core/ads/ad_helper.dart';
import '../core/ads/ad_helper.dart';
import '../core/app_bottombar.dart';
import '../core/app_color.dart';
import '../provider/app_provider.dart';

class MainPageScreen extends StatefulWidget {
  MainPageScreen({Key? key}) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;
  int _isLoadAD = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // MainPageScreen();
            },
          );

          setState(() {
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _createInterstitialAd();

    Future.delayed(Duration(seconds: 10), () {
      if (_isInterstitialAdReady) {
        _showInterstitialAd();
        log("=================== ADS INIT ==============================");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInterstitialAdReady) {
      _isLoadAD += 1;
      log("=================== NO. ${_isLoadAD.toString()} ==============================");
      if (_isLoadAD % 7 == 0) {
        log("=================== ADS SHOW ${_isLoadAD.toString()} ==============================");
        _showInterstitialAd();
      }
    }

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      bottomNavigationBar: appBottomBarWidget(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.2,
                image: AssetImage(
                  "assets/images/background.jpg",
                ),
                fit: BoxFit.cover)),
        child: context.read<AppMainProvider>().getCurrentScreen(),
      ),
    );
  }
}

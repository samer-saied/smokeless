import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static const bool _testMode = false;

  static String get appId {
    if (_testMode) {
      return "ca-app-pub-3940256099942544/3419835294";
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-6583475060576073~5001994091";
      } else if (Platform.isIOS) {
        return "<YOUR_IOS_ADMOB_APP_ID>";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  static String get interstitialAdUnitId {
    if (_testMode) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-6583475060576073/5898211163";
      } else if (Platform.isIOS) {
        return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }
}

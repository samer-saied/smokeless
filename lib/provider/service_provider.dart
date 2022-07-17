import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:time_machine/time_machine.dart';

import 'package:freesmoking/models/advice_model.dart';
import 'package:freesmoking/models/firebase_exception.dart';
import 'package:freesmoking/models/user_model.dart';

import '../services/firebase_storage.dart';

class ServicesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  FirebaseStorage firebaseStorage = FirebaseStorage();
  UserModel? currentUserData;
  User? userUID;
  bool isSmoking = true;
  AdviceModel? advice;
  double costDay = 0.0;

  ///
  ///
  ///
////////////////////////    USER    /////////////////////////////////////

  /// Create User and create document for every user
  /// Login User
  /// Forget Password
  ///
  ///
  /// Sign Out USER
  signOut() async {
    firebaseStorage.signOut().then((value) {
      currentUserData = null;
    });
  }

  /// Get User Data
  Future<UserModel?> getUserData(isForce) async {
    if (currentUserData == null || isForce == true) {
      Map<String, dynamic>? value = await firebaseStorage.getUserData();
      if (value != null) {
        currentUserData = UserModel.fromJson(value);
        isSmoking = currentUserData!.smoking ?? true;
        calucateDaily();
      }
      notifyListeners();
      return currentUserData;
    } else {
      return currentUserData;
    }
  }

  /// Update User Data
  updateUserData(Map<String, dynamic> updateData) {
    try {
      return firebaseStorage.updateUserData(updateData);
    } catch (e) {
      throw FirebaseServerException(e.toString());
    }
    // }
  }

  /// Update User SMOKING status
  changeSmokingStatus(bool smokingStatus) {
    DateTime now = DateTime.now();
    Map<String, dynamic> statusData = {
      "smoking": smokingStatus,
      "date": {
        "days": now.day.toString(),
        "months": now.month.toString(),
        "years": now.year.toString(),
      }
    };
    try {
      isSmoking = smokingStatus;
      firebaseStorage.updateUserData(statusData);
      getUserData(true);
      getAdvice(isSmoke: smokingStatus);
      notifyListeners();
    } catch (e) {
      throw FirebaseServerException(e.toString());
    }
    // }
  }

  /// Forget Password
  forgetPassword(String emailTxt) {
    try {
      firebaseStorage.forgetPassword(emailTxt);
    } catch (e) {
      throw FirebaseServerException(e.toString());
    }
  }

  /// Delete Account

  ///
////////////////////////    Advice    /////////////////////////////////////

  /// GET Advice
  getAdvice({required bool isSmoke}) async {
    Map<String, dynamic> adviceJson = await firebaseStorage.getRandomAdvice(
        collectionName: isSmoke ? "advice_SMOKE" : "advice_QUIT");
    advice = AdviceModel.fromJson(adviceJson);
    notifyListeners();
  }

  /// ADD Advice
  addAdvice() async {
    Map<String, dynamic> advice = {
      "date": "22-06-2019",
      "data": "Save your life early",
      "by": "Samer Saied",
      "index": "1",
    };
    await firebaseStorage.addAdvice(type: "smoke", newAdvice: advice);
  }

  /// Delete Advice

  ///
  ///
  ///
////////////////////////    Logic    /////////////////////////////////////

  Map<String, int> getRemainingTime(int year, int month, int day) {
    try {
      LocalDate a = LocalDate.today();
      LocalDate b = LocalDate.dateTime(DateTime(year, month, day));
      Period diff = b.periodSince(a);
      return {
        "years": diff.years * -1,
        "months": diff.months * -1,
        "days": diff.days * -1
      };
    } catch (e) {
      return {"years": 0, "months": 0, "days": 0};
    }
  }

  int collectDays(Map<String, int>? remainingDate) {
    if (remainingDate != null) {
      int years = (remainingDate["years"] ?? 0) * 365;
      int months = (remainingDate["months"] ?? 0) * 30;
      int days = (remainingDate["days"] ?? 0);
      int total = years + months + days;
      return total;
    } else {
      return 0;
    }
  }

  String formatNumber(double number) {
    // ignore: unnecessary_null_comparison
    if (number != null) {
      if (number >= 100) {
        var formatter = NumberFormat('#,##,000');
        return (formatter.format(number));
      }
      return number.toString();
    } else {
      return "0.0";
    }
  }

  gainExpectedTime(Map<String, int> remainingDate) {
    int days = collectDays(remainingDate);
    int expectedTimeByDays = 0;
    if (days > 1095) {
      int remain = days - 1095;
      double expectedTime = days + (3650 * remain / days);
      expectedTimeByDays = int.parse(expectedTime.ceil().toString());
    } else {
      double expectedTime = days + (1095 * days / 1095);
      expectedTimeByDays = int.parse(expectedTime.ceil().toString());
    }
    var date = DateTime.now();
    var newDate =
        DateTime(date.year, date.month, date.day + expectedTimeByDays);
    LocalDate a = LocalDate.today();
    LocalDate b =
        LocalDate.dateTime(DateTime(newDate.year, newDate.month, newDate.day));
    Period diff = b.periodSince(a);
    return "${(diff.years)} " +
        "Years".tr() +
        " ${diff.months} " +
        "Months".tr() +
        " ${diff.days} " +
        "Days".tr();
  }

  String gainHeartRate(Map<String, int> remainingDate) {
    int days = collectDays(remainingDate);
    if (days > 1095) {
      return "100";
    } else {
      double remain = (days / 1095) * 100;
      return "${remain.ceil()}";
    }
  }

  calucateDaily() {
    if (currentUserData!.cDaily == "0" ||
        currentUserData!.cPNumber == "0" ||
        currentUserData!.cPPrice == "0") {
      costDay = 0.0;
    } else {
      int cDaily = int.parse(currentUserData!.cDaily.toString());
      int cPacket = int.parse(currentUserData!.cPPrice.toString());
      int cNumber = int.parse(currentUserData!.cPNumber.toString());
      costDay = (cDaily / cNumber) * cPacket;
    }
    notifyListeners();
  }
}

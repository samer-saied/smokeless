import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freesmoking/core/app_color.dart';

Future<bool> alertDialogWidget(BuildContext context, String txtHeader,
    String txtBody, int buttonsNumber) async {
  // Create button
  Widget okButton = TextButton(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Text(
        "OK".tr(),
        style: TextStyle(color: AppColors.whiteColor),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );
  Widget cancelButton = TextButton(
    child: Text(
      "CANCEL".tr(),
      style: TextStyle(color: AppColors.whiteColor),
    ),
    onPressed: () {
      Navigator.of(context).pop(false);
    },
  );

  bool? answer = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.darkgeryColor,
      title: Text(
        txtHeader,
        style: TextStyle(color: AppColors.whiteColor),
      ),
      content: Text(
        txtBody,
        //"Read some pieces of advice and keep going with safe life ",
        style: TextStyle(color: AppColors.whiteColor),
      ),
      actions: (buttonsNumber == 2) ? [okButton, cancelButton] : [okButton],
    ),
  );
  if (answer == null) {
    return false;
  } else {
    return answer;
  }
}


// class KDate {
//   KDate({
//     this.now,
//     required this.year,
//     required this.month,
//     required this.date,
//     required this.lastYear,
//     required this.lastMonth,
//     required this.yesturday,
//     required this.lastWeekDate,
//   });
//   final DateTime? now;
//   final String? year;
//   final String? month;
//   final String? date;
//   final String? lastMonth;
//   final String? lastYear;
//   final String? yesturday;
//   final String? lastWeekDate;

//   factory KDate.buildWith(DateTime now) => KDate(
//         now: now,
//         year: (now.year).toString().split(" ")[0],
//         month: (now.month).toString().split(" ")[0],
//         date: (now.day).toString().split(" ")[0],
//         lastYear: (now.year - 1).toString().split(" ")[0],
//         lastMonth: DateTime(now.year, now.month, now.month)
//             .subtract(const Duration(days: 28))
//             .toString()
//             .split(" ")[0]
//             .toString()
//             .split("-")[1],
//         yesturday: DateTime(now.year, now.month, now.day)
//             .subtract(const Duration(days: 1))
//             .toString()
//             .split(" ")[0]
//             .toString()
//             .split("-")
//             .last,
//         lastWeekDate: DateTime(now.year, now.month, now.day)
//             .subtract(const Duration(days: 7))
//             .toString()
//             .split(" ")[0]
//             .toString()
//             .split("-")
//             .last,
//       );
// }

// /// Simple pie chart example.
// import 'package:flutter/material.dart';
// import 'package:freesmoking/core/app_color.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class PieChartWidget extends StatefulWidget {
//   const PieChartWidget({Key? key}) : super(key: key);

//   @override
//   State<PieChartWidget> createState() => _PieChartWidgetState();
// }

// class _PieChartWidgetState extends State<PieChartWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return SfCircularChart(
//         // backgroundColor: AppColors.geryColor,
//         palette: <Color>[
//           AppColors.blueColor,
//           AppColors.mainColor,
//         ],
//         // title: ChartTitle(text: 'Statistic'),
//         legend: Legend(
//             isVisible: true,
//             // backgroundColor: AppColors.whiteColor,
//             textStyle: TextStyle(color: AppColors.whiteColor)),
//         series: <PieSeries<_PieData, String>>[
//           PieSeries<_PieData, String>(
//               strokeColor: AppColors.whiteColor,
//               explode: true,
//               explodeIndex: 0,
//               dataSource: [
//                 _PieData(
//                   "Free smoking",
//                   70,
//                   "Green Life",
//                 ),
//                 _PieData(
//                   "smoking",
//                   30,
//                   "Danger Zone",
//                 )
//               ],
//               xValueMapper: (_PieData data, _) => data.xData,
//               yValueMapper: (_PieData data, _) => data.yData,
//               dataLabelMapper: (_PieData data, _) => data.text,
//               // strokeColor: AppColors.heartColor,
//               dataLabelSettings: DataLabelSettings(
//                   isVisible: true,
//                   useSeriesColor: false,
//                   // color: AppColors.main1Color,
//                   textStyle: TextStyle(
//                     color: AppColors.whiteColor,
//                     fontSize: 12,
//                   ))),
//         ]);
//   }
// }

// class _PieData {
//   _PieData(this.xData, this.yData, [this.text]);
//   final String xData;
//   final num yData;
//   final String? text;
// }

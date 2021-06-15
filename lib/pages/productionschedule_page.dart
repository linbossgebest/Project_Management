import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/projectschedule_model.dart';
import 'package:thzz_project_management/provide/projectshedule_provide.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class ProductionSchedulePage extends StatefulWidget {
  ProductionSchedulePage({Key key}) : super(key: key);

  @override
  _ProductionSchedulePageState createState() => _ProductionSchedulePageState();
}

class _ProductionSchedulePageState extends State<ProductionSchedulePage> {
  List<charts.Series> seriesList;

  getProjectSchedule() async {
    String token = await querySharedPerferences("token");

    getGetScheduleCost(token).then((value) {
      var resultData = value.data["resultdata"];
      if (resultData != null) {
        var data = ProjectScheduleModel.fromJson(resultData);

        Provider.of<ProjectScheduleProvide>(context, listen: false)
            .setProjectSchedule(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getProjectSchedule(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<ProjectScheduleProvide>(
              builder: (context, projectScheduleProvide, child) {
                seriesList = _createProjectScheduleData(
                    projectScheduleProvide.projectSchedule);
                return new charts.BarChart(
                  seriesList,
                  animate: false,
                  barGroupingType: charts.BarGroupingType.grouped,
                  behaviors: [
                    new charts.ChartTitle('进度统计',
                        behaviorPosition: charts.BehaviorPosition.top,
                        titleOutsideJustification:
                            charts.OutsideJustification.start),
                    new charts.SeriesLegend(),
                  ],
                  barRendererDecorator: new charts.BarLabelDecorator<String>(),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(), //加载等待动画
            );
          }
        },
      ),
    );
  }

  List<charts.Series<ProjectSchedule, String>> _createProjectScheduleData(
      ProjectScheduleModel projectSchedule) {
    List<ProjectSchedule> plansData = [];
    List<ProjectSchedule> actualData = [];
    List xAxis = projectSchedule.xAxis;
    List planseries = projectSchedule.planseries;
    List actualseries = projectSchedule.actualseries;
    if (xAxis != null) {
      for (int i = 0; i < xAxis.length; i++) {
        plansData.add(ProjectSchedule(xAxis[i], planseries[i]));
        actualData.add(ProjectSchedule(xAxis[i], actualseries[i]));
      }

      return [
        new charts.Series<ProjectSchedule, String>(
          id: '实际',
          domainFn: (ProjectSchedule ps, _) => ps.month.toString() + "月",
          measureFn: (ProjectSchedule ps, _) => ps.series,
          data: actualData,
          labelAccessorFn: (ProjectSchedule ps, _) => ps.series.toString(),
        ),
        new charts.Series<ProjectSchedule, String>(
          id: '计划',
          domainFn: (ProjectSchedule ps, _) => ps.month.toString() + "月",
          measureFn: (ProjectSchedule ps, _) => ps.series,
          data: plansData,
          labelAccessorFn: (ProjectSchedule ps, _) => ps.series.toString(),
        ),
      ];
    }
  }
}

class ProjectSchedule {
  final int month;
  final int series;

  ProjectSchedule(this.month, this.series);
}

// class _ProductionSchedulePageState extends State<ProductionSchedulePage> {
//   List<charts.Series> seriesList;

//   List<QualityModel> qualityList;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<QualityListProvide>(
//       builder: (context, qualityProvide, child) {
//         qualityList = qualityProvide.qualityList.data;
//         seriesList = _createData();
//         return new charts.BarChart(
//           seriesList,
//           animate: false,
//           barGroupingType: charts.BarGroupingType.grouped,
//           behaviors: [
//             new charts.ChartTitle('质量问题统计',
//                 behaviorPosition: charts.BehaviorPosition.top,
//                 titleOutsideJustification: charts.OutsideJustification.start),
//             new charts.SeriesLegend(),
//           ],
//           barRendererDecorator: new charts.BarLabelDecorator<String>(),
//         );
//       },
//     );
//   }

//   List<charts.Series<QualityModel, String>> _createData() {
//     return [
//       new charts.Series<QualityModel, String>(
//         id: '问题',
//         domainFn: (QualityModel quality, _) => quality.state,
//         measureFn: (QualityModel quality, _) => int.parse(quality.stateCount),
//         data: qualityList,
//         labelAccessorFn: (QualityModel quality, _) => quality.state.toString(),
//       )
//     ];
//   }
// }

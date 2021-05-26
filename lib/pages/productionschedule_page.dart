import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/quality_model.dart';
import 'package:thzz_project_management/provide/qualitysum_provide.dart';

// class ProductionSchedulePage extends StatelessWidget {
//   List<charts.Series> seriesList;

//   List<QualityModel> qualityList;

//   @override
//   Widget build(BuildContext context) {
//     qualityList = Provider.of<QualityListProvide>(context, listen: false)
//         .qualityList
//         .data;
//     seriesList = _createData();
//     return new charts.BarChart(
//       seriesList,
//       animate: false,
//       barGroupingType: charts.BarGroupingType.grouped,
//       behaviors: [
//         new charts.ChartTitle('质量问题统计',
//             behaviorPosition: charts.BehaviorPosition.top,
//             titleOutsideJustification: charts.OutsideJustification.start),
//         new charts.SeriesLegend(),
//       ],
//       barRendererDecorator: new charts.BarLabelDecorator<String>(),
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

class ProductionSchedulePage extends StatefulWidget {
  ProductionSchedulePage({Key key}) : super(key: key);

  @override
  _ProductionSchedulePageState createState() => _ProductionSchedulePageState();
}

class _ProductionSchedulePageState extends State<ProductionSchedulePage> {
  List<charts.Series> seriesList;

  List<QualityModel> qualityList;

  @override
  Widget build(BuildContext context) {
    return Consumer<QualityListProvide>(
      builder: (context, qualityProvide, child) {
        qualityList = qualityProvide.qualityList.data;
        seriesList = _createData();
        return new charts.BarChart(
          seriesList,
          animate: false,
          barGroupingType: charts.BarGroupingType.grouped,
          behaviors: [
            new charts.ChartTitle('质量问题统计',
                behaviorPosition: charts.BehaviorPosition.top,
                titleOutsideJustification: charts.OutsideJustification.start),
            new charts.SeriesLegend(),
          ],
          barRendererDecorator: new charts.BarLabelDecorator<String>(),
        );
      },
    );
  }

  List<charts.Series<QualityModel, String>> _createData() {
    return [
      new charts.Series<QualityModel, String>(
        id: '问题',
        domainFn: (QualityModel quality, _) => quality.state,
        measureFn: (QualityModel quality, _) => int.parse(quality.stateCount),
        data: qualityList,
        labelAccessorFn: (QualityModel quality, _) => quality.state.toString(),
      )
    ];
  }
}

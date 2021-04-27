import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProductionSchedulePage extends StatelessWidget {
  List<charts.Series> seriesList;
  //final bool animate;
  // ProjectBoardPage(this.seriesList, {this.animate});

  // factory ProjectBoardPage.withSampleData() {
  //   return new ProjectBoardPage(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    seriesList = _createSampleData();
    return new charts.BarChart(
      seriesList,
      animate: false,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
        new charts.ChartTitle('进度统计',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start),
        new charts.SeriesLegend(),
      ],
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('1月', 5),
      new OrdinalSales('2月', 25),
      new OrdinalSales('3月', 90),
      new OrdinalSales('4月', 75),
      new OrdinalSales('5月', 65),
      new OrdinalSales('6月', 35),
    ];

    final tableSalesData = [
      new OrdinalSales('1月', 25),
      new OrdinalSales('2月', 50),
      new OrdinalSales('3月', 10),
      new OrdinalSales('4月', 20),
      new OrdinalSales('5月', 15),
      new OrdinalSales('6月', 20),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: '实际',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        labelAccessorFn: (OrdinalSales sales, _) => sales.sales.toString(),
      ),
      new charts.Series<OrdinalSales, String>(
        id: '计划',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        labelAccessorFn: (OrdinalSales sales, _) => sales.sales.toString(),
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

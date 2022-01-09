import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  late final List<charts.Series<dynamic, DateTime>> seriesList;
  late final bool animate;

  /// Create random data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createRandomData() {
    final random = new Random();

    final data = [
      new TimeSeriesSales(new DateTime(2021, 9, 19), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2021, 9, 26), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2021, 10, 3), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2021, 10, 10), random.nextInt(100)),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Reading',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Chart',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 1,

        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(50.0),
                color: Colors.blue[200],
                child: new charts.TimeSeriesChart(
                  seriesList,
                  animate: animate,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(50.0),
                color: Colors.blue[200],
                child: Text(
                    "Total Reading Time: "
                ),
              ),
              Container(
                padding: EdgeInsets.all(50.0),
                color: Colors.blue[200],
                child: Text(
                    "Last Reading Time: "
                ),
              ),
              Container(
                padding: EdgeInsets.all(50.0),
                color: Colors.blue[200],
                child: Text(
                    "Total Words Read: "
                ),
              ),
              Container(
                padding: EdgeInsets.all(50.0),
                color: Colors.blue[200],
                child: Text(
                    "Last Words Read: "
                ),
              ),
            ],
          ),
        )
    );



  }

}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
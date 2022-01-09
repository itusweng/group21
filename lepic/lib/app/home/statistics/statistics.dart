import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  late final List<charts.Series<dynamic, num>> seriesList;
  late final bool animate;



  /// Creates a [LineChart] with sample data and no transition.


  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
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
                  padding: EdgeInsets.all(10.0),
                  height: 200,
                  width: 400,
                  child: new charts.LineChart(_createSampleData(), animate: true)
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: 300,
                padding: EdgeInsets.all(10),
                color: Colors.blue[200],
                child: Text(
                    "Total Reading Time: "
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: 300,
                padding: EdgeInsets.all(10),
                color: Colors.blue[200],
                child: Text(
                    "Last Reading Time: "
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: 300,
                padding: EdgeInsets.all(10),
                color: Colors.blue[200],
                child: Text(
                    "Total Words Read: "
                ),
              ),
              SizedBox(height:10),
              Container(
                height: 40,
                width: 300,
                padding: EdgeInsets.all(10),
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
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 50),
      new LinearSales(3, 90),
      new LinearSales(4, 60),
      new LinearSales(5, 70),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
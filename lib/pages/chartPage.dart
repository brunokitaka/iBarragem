import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartPage extends StatefulWidget{
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>{
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context){
    var data = [
      new DayAverage(DateTime(2018, 9, 1), 1),
      new DayAverage(DateTime(2018, 9, 2), 42),
      new DayAverage(DateTime(2018, 9, 3), 69),
      new DayAverage(DateTime(2018, 9, 4), 54),
      new DayAverage(DateTime(2018, 9, 5), 5),
      new DayAverage(DateTime(2018, 9, 6), 21),
      new DayAverage(DateTime(2018, 9, 7), 2),
      new DayAverage(DateTime(2018, 9, 8), 98),
      new DayAverage(DateTime(2018, 9, 9), 5),
      new DayAverage(DateTime(2018, 9, 10), 77),
      new DayAverage(DateTime(2018, 9, 11), 1),
      new DayAverage(DateTime(2018, 9, 12), 42),
      new DayAverage(DateTime(2018, 9, 13), 6),
      new DayAverage(DateTime(2018, 9, 14), 54),
      new DayAverage(DateTime(2018, 9, 15), 5),
      new DayAverage(DateTime(2018, 9, 16), 21),
      new DayAverage(DateTime(2018, 9, 17), 2),
      new DayAverage(DateTime(2018, 9, 18), 98),
      new DayAverage(DateTime(2018, 9, 19), 5),
      new DayAverage(DateTime(2018, 9, 20), 77),
      new DayAverage(DateTime(2018, 9, 21), 1),
      new DayAverage(DateTime(2018, 9, 22), 42),
      new DayAverage(DateTime(2018, 9, 23), 6),
      new DayAverage(DateTime(2018, 9, 24), 54),
      new DayAverage(DateTime(2018, 9, 25), 5),
      new DayAverage(DateTime(2018, 9, 26), 21),
      new DayAverage(DateTime(2018, 9, 27), 2),
      new DayAverage(DateTime(2018, 9, 28), 98),
      new DayAverage(DateTime(2018, 9, 29), 5),
      new DayAverage(DateTime(2018, 9, 30), 77),
      new DayAverage(DateTime(2018, 9, 31), _counter),
    ];

    var series = [
      new charts.Series(
        domainFn: (DayAverage clickData, _) => clickData.day,
        measureFn: (DayAverage clickData, _) => clickData.clicks,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = new charts.TimeSeriesChart(
      series,
      animate: true,
    );
    
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            chartWidget,
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class DayAverage {
  final DateTime day;
  final int clicks;

  DayAverage(this.day, this.clicks);
}
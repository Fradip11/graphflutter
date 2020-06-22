import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /* Timer timer;
    timer = Timer(Duration(seconds: 5), () {
      setState(() {
        getDynamicData();
      });
    });*/
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 550,
              child: SfCartesianChart(
                title: ChartTitle(text: "Suhu Tanaman A"),
                primaryXAxis: DateTimeAxis(
                    intervalType: DateTimeIntervalType.seconds, interval: 2),
                primaryYAxis: NumericAxis(
                    title: AxisTitle(text: "Suhu"),
                    labelFormat: "{value} degrees"),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(
                    enable: true, activationMode: ActivationMode.longPress),
                zoomPanBehavior: ZoomPanBehavior(
                    enableDoubleTapZooming: true,
                    enablePanning: true,
                    zoomMode: ZoomMode.x),
                series: <ChartSeries>[
                  StackedLineSeries<SalesData, double>(
                      dataSource: getDynamicData(),
                      name: "Suhu Tanaman",
                      legendIconType: LegendIconType.circle,
                      xValueMapper: (SalesData sales, _)=> sales.suhu,
                      yValueMapper: (SalesData sales, _) => sales.waktu,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SuhuData {
  double suhuSekarang;
  SuhuData(this.suhuSekarang);
}

class SalesData {
  double waktu, suhu;
  SalesData(this.waktu, this.suhu);
}

dynamic getColumnData() {
  List<SalesData> columnData = <SalesData>[
    SalesData(10, 24),
    SalesData(10.30, 27),
    SalesData(11, 29),
    SalesData(11.30, 28.5),
    SalesData(12, 26.5),
    SalesData(12.5, 30.5),
    SalesData(13, 26.5),
  ];
  return columnData;
}

List<SalesData> dynamicData = <SalesData>[];
double j = 10.00;

dynamic getDynamicData() {
  j += 0.05;
  double value = 25;
  Random rand = new Random();

  if (rand.nextDouble() > 0.5) {
    value += rand.nextDouble();
  } else {
    value -= rand.nextDouble();
  }
  if (j > 50) {
    dynamicData.removeAt(0);
  }
  dynamicData.add(SalesData(j.toDouble(), value));
}

dynamic getHugeData() {
  List<SalesData> hugeData = <SalesData>[];
  double value = 100;
  Random rand = new Random();

  for (int i = 0; i < 1000; i++) {
    if (rand.nextDouble() > 0.5) {
      value += rand.nextDouble();
    } else {
      value -= rand.nextDouble();
    }
    hugeData.add(SalesData(i.toDouble(), value));
  }
  return hugeData;
}

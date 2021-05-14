import 'package:flutter/material.dart';
import 'package:tqttio_client/model/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  final Dashboard dashboard;
  DashboardScreen({Key key, @required this.dashboard}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String connectStatus = "Bağlandı.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.dashboard.dashboardName),
        ),
        body: Column(
          children: [
            buildConnectionStatusBar(),
          ],
        ));
  }

  Container buildConnectionStatusBar() {
    return Container(
      height: MediaQuery.of(context).size.height %35 ,
      color: Colors.greenAccent[400],
      child: Center(
        child: Text("Bağlantı durumu: "+ connectStatus), 
      )
    );
  }
}

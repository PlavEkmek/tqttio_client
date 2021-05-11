import 'package:flutter/material.dart';
import 'package:tqttio_client/screens/dashboards_screen.dart';
import 'package:tqttio_client/state_widget.dart';

void main() {
  runApp(MyApp());
  }
  
  class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return StateWidget(
          child: MaterialApp(
        home: DashboardsPage(),
      ),
    ); 
  }
}

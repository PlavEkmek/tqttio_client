import 'package:flutter/material.dart';
import 'package:tqttio_client/state_widget.dart';

class DashboardsPage extends StatefulWidget {
  List<String> dashboards;
  DashboardsPage({Key key, this.dashboards}) : super(key: key);

  @override
  _DashboardsPageState createState() => _DashboardsPageState(dashboards);
}

class _DashboardsPageState extends State<DashboardsPage> {
  List<String> dashboards;

  int get dashboardCount {
    if (dashboards == null)
      return 0;
    else
      return dashboards.length;
  }

  _DashboardsPageState(this.dashboards);

  @override
  Widget build(BuildContext context) {
    dashboards = StateInheritedWidget.of(context).state.dashboards;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: dashboardCount,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(dashboards[index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}

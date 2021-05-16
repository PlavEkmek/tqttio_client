import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqttio_client/controller/dashboard_notifier.dart';
import 'package:tqttio_client/model/dashboard.dart';
import 'package:tqttio_client/screen/dashboardAdd_screen.dart';
import 'package:tqttio_client/screen/dashboard_screen.dart';

class DashboardsListScreen extends StatefulWidget {
  @override
  _DashboardsListScreenState createState() => _DashboardsListScreenState();
}

class _DashboardsListScreenState extends State<DashboardsListScreen> {
  @override
  Widget build(BuildContext context) {
    var dashboardNotifier = Provider.of<DashboardNotifier>(context);
    var dashboards = dashboardNotifier.dashboards;

    return Scaffold(
        appBar: AppBar(
          title: Text("Kontroller"),
        ),
        body: Column(
          children: [
            Expanded(
                child: Consumer<DashboardNotifier>(
              builder: (context, notifier, __) => ListView.builder(
                  itemCount: dashboards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildDashboardListItem(dashboards, index);
                  }),
            )),
          ],
        ),
        floatingActionButton: buildDashboardAddButton());
  }

  FloatingActionButton buildDashboardAddButton() {
    return FloatingActionButton(
        tooltip: "Otomasyon Ekle",
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardAddScreen(
                        mode: "Ekle",
                      )));
        });
  }

  Card buildDashboardListItem(List<Dashboard> dashboards, int index) {
    return Card(
      elevation: 5.0,
      child: Consumer<DashboardNotifier>(
        builder: (context, notifier, __) => Container(
          padding: EdgeInsets.only(right: 10.0),
          child: Row(
            children: [
              Flexible(child: buildDashboardListTile(dashboards[index],notifier)),
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildDashboardEditButton(dashboards[index]),
                  Container(
                    width: MediaQuery.of(context).size.width % 8,
                  ),
                  buildDashboardDeleteButton(notifier, index)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildDashboardListTile(Dashboard dash,DashboardNotifier notifier) {
    return ListTile(
      title: Text(dash.dashboardName),
      subtitle: Text("Bağlanmak için tıklayın."),
      onTap: () {
        notifier.selectedDashboard = dash;
        Navigator.push(context, MaterialPageRoute(builder: (builder)=>DashboardScreen(dashboard:dash)));
      },
    );
  }

  ElevatedButton buildDashboardEditButton(Dashboard dash) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => DashboardAddScreen(
                      mode: "Kaydet", dashboardName: dash.dashboardName)));
        },
        child: Icon(Icons.edit));
  }

  ElevatedButton buildDashboardDeleteButton(
      DashboardNotifier notifier, int index) {
    return ElevatedButton(
      onPressed: () {
        notifier.deleteDashboard(index);
      },
      child: Icon(Icons.delete),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tqttio_client/screens/dashboardAdd_screen.dart';
import 'package:tqttio_client/state_widget.dart';

// ignore: must_be_immutable
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
    var corestate= StateInheritedWidget.of(context);
    dashboards = corestate.state.dashboards;
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
                      onTap: (){
                        foo();
                      },
                    );
                  }),
            )
          ],
        ),
        floatingActionButton: dashboardAddButton());
  }

  FloatingActionButton dashboardAddButton() {
    return FloatingActionButton(
      tooltip: "Otomasyon Ekle",
      child: Icon(Icons.add,),
      onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardAdd())).then((value) => { 
            
            foo()
            });
     
    });
  }
  void foo(){
    print("Hi!");
  }
}

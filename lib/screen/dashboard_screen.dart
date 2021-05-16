import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:tqttio_client/controller/dashboard_notifier.dart';
import 'package:tqttio_client/controller/mqttServer_controller.dart';
import 'package:tqttio_client/model/dashboard.dart';
import 'package:tqttio_client/model/tool.dart';
import 'package:tqttio_client/screen/dashboardIndicatiorAdd.dart';
import 'package:tqttio_client/screen/dashboardSwitchAdd_screen.dart';
import 'package:tqttio_client/widget/IndicatorTool_widget.dart';
import 'package:tqttio_client/widget/SwitchTool_widget.dart';

class DashboardScreen extends StatefulWidget {
  final Dashboard dashboard;
  DashboardScreen({Key key, @required this.dashboard}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

enum dashboardToolList {
  anahtar,
  gosterge,
}

enum toolMode { add, edit }
enum toolTypes {switchbutton,indicator}
class _DashboardScreenState extends State<DashboardScreen>
    with MqttServerControlleronMixin {
  void fun() async {
    client = MqttServerClient('192.168.0.103', '');
    await initializeClient(client);
    await mqttConnect(client);
  }

  _DashboardScreenState() {
    fun();
  }
  MqttServerClient client;
  String connectStatus = "Bağlandı.";
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.dashboard.dashboardName), actions: [
          PopupMenuButton(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  ),
                margin:EdgeInsets.only(top:13,bottom:13,right:10), child: Icon(Icons.add)),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<dashboardToolList>>[
                    buildSwitchPopupButton(),
                    buildIndicatorPopupButton()
                  ])
        ]),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[900]),
          child: Column(
            children: [buildConnectionStatusBar(), buildDashboardTools(context)],
          ),
        ));
  }

  Container buildConnectionStatusBar() {
    return Container(
        height: MediaQuery.of(context).size.height % 35,
        color: Colors.greenAccent[400],
        child: Center(
          child: Text("Bağlantı durumu: " + connectStatus),
        ));
  }

  PopupMenuItem<dashboardToolList> buildSwitchPopupButton() {
    return PopupMenuItem<dashboardToolList>(
        value: dashboardToolList.anahtar,
        child: TextButton(
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.blueGrey[900],
              ),
              Text('Anahtar')
            ],
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardSwitchAdd()));
          },
        ));
  }

  PopupMenuItem<dashboardToolList> buildIndicatorPopupButton() {
    return PopupMenuItem<dashboardToolList>(
      value: dashboardToolList.gosterge,
      child: TextButton(
              onPressed: () { 
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardIndicatorAdd()));
               },
              child: Row(
          children: [
            Icon(
              Icons.wysiwyg,
              color: Colors.blueGrey[900],
            ),
            Text('Gösterge')
          ],
        ),
      ),
    );
  }

  Container buildDashboardTools(BuildContext context) {
    return Container(
        child: Expanded(
            child: Consumer<DashboardNotifier>(
                builder: (_, notifier, __) => buildToolsGrid(notifier))));
  }

  GridView buildToolsGrid(DashboardNotifier notifier) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(10),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 10,
      children: notifier.selectedDashboard.dashboardTools
          .map((tool) => tool.type=="Switch"?SwitchToolWidget(tool:tool):IndicatorToolWidget(tool:tool)
          ).toList(),
    );
  }
}

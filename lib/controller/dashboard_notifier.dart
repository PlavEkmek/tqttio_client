import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:tqttio_client/controller/mqttServer_controller.dart';
import 'package:tqttio_client/model/dashboard.dart';
import 'package:tqttio_client/model/tool.dart';

class DashboardNotifier extends ChangeNotifier {
  DashboardNotifier() {
    this.selectedClient =
        MqttServerController(MqttServerClient('192.168.0.103', ''));
        mqttSubscribeListen();
  }

  List<Dashboard> _dashboards = [];
  Dashboard selectedDashboard;
  UnmodifiableListView<Dashboard> get dashboards =>
      UnmodifiableListView(_dashboards);
  Tool selectedTool = Tool.empty();
  MqttServerController selectedClient;

  void mqttSubscribeListen() {
    String payload;
    selectedClient.client.updates
        .listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      payload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      for (var tool in selectedDashboard.dashboardTools)
        if (recMess.payload.variableHeader.topicName == tool.topicName) {
          tool.text = payload;
          notifyListeners();
        }
    });
  }

  void addTool(Tool tool) {
    selectedDashboard.dashboardTools.add(tool);
    notifyListeners();
  }

  addDashboard(Dashboard dashboard) {
    _dashboards.add(dashboard);
    notifyListeners();
  }

  deleteDashboard(int index) {
    _dashboards.removeAt(index);
    notifyListeners();
  }

  updateDashboard(Dashboard oldDashboard, Dashboard newdashboard) {
    var index = _dashboards.indexWhere(
        (element) => element.dashboardName == oldDashboard.dashboardName);
    if (index != -1) {
      _dashboards[index].dashboardName = newdashboard.dashboardName;
    }
    notifyListeners();
  }

  updateTool(Tool tool, String payload) {
    for (var tol in selectedDashboard.dashboardTools) {
      if (tol.toolName == tool.toolName) {
        tol.text = payload;
        notifyListeners();
        return;
      }
    }
  }
}

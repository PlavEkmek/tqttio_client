import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:tqttio_client/model/dashboard.dart';
import 'package:tqttio_client/model/tool.dart';

class DashboardNotifier extends ChangeNotifier{
  List<Dashboard> _dashboards = [];
  Dashboard selectedDashboard;
  UnmodifiableListView<Dashboard> get dashboards => UnmodifiableListView(_dashboards);
  Tool selectedTool=Tool.empty();

  void addTool(Tool tool){
    selectedDashboard.dashboardTools.add(tool);
    notifyListeners();
    }
  addDashboard(Dashboard dashboard){
    _dashboards.add(dashboard);
    notifyListeners();
  }

  deleteDashboard(int index){
    _dashboards.removeAt(index);
    notifyListeners();
  }
  updateDashboard(Dashboard oldDashboard, Dashboard newdashboard){
    var index =_dashboards.indexWhere((element) => element.dashboardName == oldDashboard.dashboardName);
    if(index!=-1){
      _dashboards[index].dashboardName = newdashboard.dashboardName;
    }
    notifyListeners();
  }
}
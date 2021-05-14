import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:tqttio_client/model/dashboard.dart';

class DashboardNotifier extends ChangeNotifier{
  List<Dashboard> _dashboards = [];

  UnmodifiableListView<Dashboard> get dashboards => UnmodifiableListView(_dashboards);

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
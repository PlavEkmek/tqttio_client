import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tqttio_client/model/tool.dart';

class Dashboard extends ChangeNotifier{
  //Host name always stored with url. Default www.tqttio.com setted to connection 
  String _hostNameWithUrl = "www.tqttio.com ";
  //Shown name inside listed dashboardscreen  
  String _dashboardName="";

  int _portNumber=1883;

List<Tool> _dashboardTools=[];

  List<Tool> get dashboardTools{
    return _dashboardTools;
  }

  String get dashboardName{
    return _dashboardName;
  }
  
  set portNumber(String port){
    this._portNumber = int.tryParse(port);
    notifyListeners();
  }
  set dashboardName(String dashboardName){
    if(dashboardName==null) this._dashboardName = "Isimsiz otomasyon";
     else this._dashboardName = dashboardName;
     notifyListeners();
  }

  set hostName(String host) {
    this._hostNameWithUrl = host;
    notifyListeners();
  }

  Dashboard({String dashboardName,String hostName,String portnumber}){
    this.dashboardName = dashboardName; 
    this.hostName = hostName;
    this.portNumber = portnumber;
  }
  Dashboard.empty(){
    this.dashboardName = ""; 
    this.hostName = "";
    this.portNumber = "";
  }
}
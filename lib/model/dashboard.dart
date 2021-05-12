class Dashboard {
  //Host name always stored with url. Default www.tqttio.com setted to connection 
  String _hostNameWithUrl = "www.tqttio.com ";
  //Shown name inside listed dashboardscreen  
  String _dashboardName;

  int _portNumber;

  get dashboardName{
    return _dashboardName;
  }
  set portNumber(String port){
    this._portNumber = int.tryParse(port);
  }
  set dashboardName(String dashboardName){
    if(dashboardName==null) this._dashboardName = "Isimsiz otomasyon";
     else this._dashboardName = dashboardName;
  }

  set hostName(String host) {
    this._hostNameWithUrl = host;
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

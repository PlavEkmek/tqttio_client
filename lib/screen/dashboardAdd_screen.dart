import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqttio_client/controller/dashboard_notifier.dart';
import 'package:tqttio_client/model/dashboard.dart';
import 'package:tqttio_client/validation/dashboard_validate.dart';

class DashboardAddScreen extends StatefulWidget {

  String dashboardName;
  
  String buttonName ;


  DashboardAddScreen({Key key, @required String mode,this.dashboardName}) : super(key: key){
    if(mode=="Ekle") this.buttonName = 'Ekle'; 
    else this.buttonName='Kaydet';
  }

  @override
  _DashboardAddScreenState createState() => _DashboardAddScreenState();
}

class _DashboardAddScreenState extends State<DashboardAddScreen>
    with DashboardValidateonMixin {
  var dashboard = Dashboard.empty();
  var oldDashboard= Dashboard.empty();

  //if this  value true, its mean our page Add Dashboard, otherwise  its hold false value to Edit Dashboard Mode.
  String  getTitleName(){
    if(widget.buttonName=="Ekle") {
      return "Ekle";
    }
    else return "Düzenle";
  } 

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Otomasyon "+getTitleName())),
        body: Container(
          margin: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDashboardName(),
                buildHostNameField(),
                buildPortNumberField(),
                buildSubmitButton(context)
              ],
            ),
          ),
        ));
  }

  TextFormField buildDashboardName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Otomasyon Adı", hintText: "Örn: Ev Otomasyonum"),
      validator: validateDashboardName,
      initialValue: initializeDashboardName(),
            autofocus: true,
            onSaved: (String value) {
              dashboard.dashboardName = value;
            },
          );
        }
      
        TextFormField buildHostNameField() {
          return TextFormField(
            decoration: InputDecoration(
                labelText: "Sunucu adresi", hintText: "Örn: www.tqttio.com"),
            initialValue: "www.tqttio.com",
            validator: validateHostName,
            readOnly: true,
            onSaved: (String value) {
              dashboard.hostName = value;
            },
          );
        }
      
        TextFormField buildPortNumberField() {
          return TextFormField(
            decoration: InputDecoration(
                labelText: "Port Adresi",
                hintText: "Örn: 1883 [mqtt varsayılan port numarası]"),
            initialValue: "1883",
            validator: validatePortNumber,
            readOnly: true,
            onSaved: (String value) {
              dashboard.portNumber = value;
            },
          );
        }
      
        Consumer<DashboardNotifier> buildSubmitButton(BuildContext context) {
          return Consumer<DashboardNotifier>(
              builder: (context, notifier, __) => ElevatedButton(
                    onPressed: () => saveSettings(context),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Icon(Icons.add), Text(widget.buttonName)]),
                  ));
        }
      
        saveSettings(BuildContext context) {
            //Saving inputs after validate
          if (formKey.currentState.validate()) 
          {
            oldDashboard.dashboardName=widget.dashboardName;
            formKey.currentState.save();
            
          // For outside from context add listen:false param
          var dashboardNotifier = Provider.of<DashboardNotifier>(context, listen: false);
          if(widget.dashboardName == null)
          dashboardNotifier.addDashboard(dashboard);
          else dashboardNotifier.updateDashboard(oldDashboard, dashboard);
        
          Navigator.pop(context);
          }
        }
      
        String initializeDashboardName() {
          if(widget.dashboardName == null) return "";
          else return widget.dashboardName;
        }
}

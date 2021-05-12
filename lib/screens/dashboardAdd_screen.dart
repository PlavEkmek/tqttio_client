
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tqttio_client/model/dashboard.dart';
import 'package:tqttio_client/state_widget.dart';
import 'package:tqttio_client/validations/dashboard_validator.dart';

class DashboardAdd extends StatefulWidget {
  @override
  _DashboardAddState createState() => _DashboardAddState();
}

class _DashboardAddState extends State<DashboardAdd>
    with DashboardValidatoronMixin {
  var dashboard = Dashboard.empty();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Otomasyon Ekle")),
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
      initialValue: "",
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

  ElevatedButton buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => saveSettings(context),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.add), Text("Ekle")]),
    );
  }

  saveSettings(BuildContext context) {
    //Saving inputs after validate
    if (formKey.currentState.validate()) formKey.currentState.save();
    var state = StateInheritedWidget.of(context);
    state.addDashboard(dashboard.dashboardName);
    Navigator.pop(context);
  }
}

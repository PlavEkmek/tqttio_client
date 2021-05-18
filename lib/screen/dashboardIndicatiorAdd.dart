import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqttio_client/controller/dashboard_notifier.dart';
import 'package:tqttio_client/model/tool.dart';
import 'package:tqttio_client/validation/tool_validate.dart';

class DashboardIndicatorAdd extends StatefulWidget {
  DashboardIndicatorAdd({Key key}) : super(key: key);

  @override
  _DashboardIndicatorAddState createState() => _DashboardIndicatorAddState();
}

class _DashboardIndicatorAddState extends State<DashboardIndicatorAdd> with ToolValidateonMixin{

 final formKey = GlobalKey<FormState>();
  bool addMode = true;
  Tool tool = Tool.empty();
  @override
  Widget build(BuildContext context) {
      var tool =
        Provider.of<DashboardNotifier>(context, listen: false).selectedTool;
  String checkModeTitle() {
      if ((tool.toolName == "" && tool.topicName == "") || tool == null) {
        addMode = true;
        return "Ekle";
      } else {
        addMode = false;
        return "Düzenle";
      }
    }
  String modeTitle = checkModeTitle();
    return Scaffold(
      appBar: AppBar(
        title: Text("Anahtar " + modeTitle),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildToolName(tool),
              buildTopicName(tool),
              buildSubmitButton(context)
            ],
          ),
        ),
      ),
    );
  }
  initializeToolName(Tool tool) {
    if (addMode)
      return "";
    else
      return tool.toolName;
  }
  initializeTopicName(Tool tool) {
    if (addMode)
      return "";
    else
      return tool.topicName;
  }
  TextFormField buildToolName(Tool tool) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Gösterge adı", hintText: "Örn: Sıcaklık Göstergesi"),
      validator: validateToolName,
      initialValue: initializeToolName(tool),
      autofocus: true,
      onSaved: (String value) {
        this.tool.toolName = value;
      },
    );
  }
   TextFormField buildTopicName(Tool tool) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Topic Adı", hintText: "Örn: Motordurum"),
      validator: validateTopicName,
      initialValue: initializeTopicName(tool),
      autofocus: true,
      onSaved: (String value) {
        this.tool.topicName = value;
      },
    );
  }
  Consumer<DashboardNotifier> buildSubmitButton(BuildContext context) {
    String buttonText;
    if (addMode)
      buttonText = "Ekle";
    else
      buttonText = "Kaydet";
    return Consumer<DashboardNotifier>(
        builder: (context, notifier, __) => ElevatedButton(
              onPressed: () => saveSettings(context,notifier),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.add), Text(buttonText)]),
            ));
  }
  saveSettings(BuildContext context, DashboardNotifier notifier) {
    if (formKey.currentState.validate()) formKey.currentState.save();
    this.tool.type= "Indicator";
    notifier.addTool(this.tool);
    print(this.tool.topicName);
    notifier.selectedClient.mqttSubscribe(this.tool.topicName);
    Navigator.pop(context);
  }
}
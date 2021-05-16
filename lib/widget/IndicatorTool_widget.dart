import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqttio_client/controller/dashboard_notifier.dart';
import 'package:tqttio_client/model/tool.dart';

class IndicatorToolWidget extends StatefulWidget {
  Tool tool;
  IndicatorToolWidget({Key key, this.tool}) : super(key: key);

  @override
  _IndicatorToolWidgetState createState() => _IndicatorToolWidgetState(tool);
}

class _IndicatorToolWidgetState extends State<IndicatorToolWidget> {
  Tool tool;
  _IndicatorToolWidgetState(this.tool);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:MediaQuery.of(context).size.width % 45,bottom:MediaQuery.of(context).size.width % 45),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(3)),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(margin: EdgeInsets.only(top: 12),
                child: Center(
                  child: Consumer<DashboardNotifier>(builder:(_,notifier,__) => Text(tool.text,style: TextStyle(fontSize: 20),)),
                  ),
                ),
              ),
            Container(
              child: Text(tool.toolName,style: TextStyle(fontSize: 16),),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tqttio_client/model/tool.dart';

class SwitchToolWidget extends StatefulWidget {
  Tool tool;
  SwitchToolWidget({Key key, this.tool}) : super(key: key);

  @override
  _SwitchToolWidgetState createState() => _SwitchToolWidgetState(tool);
}

class _SwitchToolWidgetState extends State<SwitchToolWidget> {
  Tool tool;
  _SwitchToolWidgetState(this.tool);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width % 45),
      decoration: BoxDecoration(
          color: tool.value?Colors.greenAccent:Colors.blue[100],
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(3)),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 12),
                child: Center(
                  child: Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      value: tool.value,
                      onChanged: (val) {
                        setState(() {
                          tool.value = val;
                        });
                      },
                    ),
                  ),
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
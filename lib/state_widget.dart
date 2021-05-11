import 'package:flutter/material.dart';
import 'package:tqttio_client/data/core_state.dart';

class StateWidget extends StatefulWidget {
  final Widget child;

  StateWidget({Key key, @required this.child}) : super(key: key);
  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  CoreState state = new CoreState(dashboards: ["Sera otomasyon", "Ev otomasyon"]);

  void addDashboard(String value) {
    state.dashboards.add(value);
    final dashboards = state.dashboards;
    final newState = state.copy(dashboards: dashboards);
    setState(() {
      state= newState;
    });
  }

  @override
  Widget build(BuildContext context) => StateInheritedWidget(
        child: widget.child,
        state: state,
        stateWidget: this,
      );
}

class StateInheritedWidget extends InheritedWidget {
  final CoreState state;
  final _StateWidgetState stateWidget;
  final Widget child;

  StateInheritedWidget(
      {Key key,
      this.child,
      @required this.state,
      @required this.stateWidget})
      : super(key: key, child: child);

  
  //Looking to context tree to find StateInheritedWidget widget to reach data
  static _StateWidgetState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StateInheritedWidget>()
        .stateWidget;
  }

  //Checking data changes with overrided operand == 
  @override
  bool updateShouldNotify(StateInheritedWidget oldWidget) {
    return oldWidget.state != state;
  }
}

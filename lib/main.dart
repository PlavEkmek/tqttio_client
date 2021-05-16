import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tqttio_client/controller/dashboard_notifier.dart';
import 'package:tqttio_client/screen/dashboardsList_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => DashboardNotifier(),
      ),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DashboardsListScreen(), debugShowCheckedModeBanner: false);
  }
}

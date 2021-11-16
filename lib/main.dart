import 'package:contact_tracing/NavDrawer.dart';
import 'package:contact_tracing/proximitytasks/BluetoothProximityDetection.dart';
import 'package:flutter/material.dart';
import 'package:contact_tracing/static/ProximityDetectionPage.dart';
import 'package:contact_tracing/static/BlockchainSyncPage.dart';
import 'static/SQLTestingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String titleString = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proximity Detection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Pages(),
    );
  }
}

class Pages extends StatefulWidget {
  //const Pages({Key key}) : super(key: key);
  const Pages({Key? key}) : super(key: key);

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int currentIndex = 0;
  List<Widget> currentChildren = [
    ProximityDetectionPage(
      onButtonPressed: BluetoothProximityDetection.instance.toggleProximityScan,
      checkStarted: BluetoothProximityDetection.instance.getStartStop,
      disposeMethod: BluetoothProximityDetection.instance.disposeMethod,
    ),
    BlockchainSyncPage(),
    SQLTestingPage(),
  ];
  List<String> titleStrings = [
    "Bluetooth Proximity Detection",
    "Blockchain Sync",
    "Testing SQLDatabase"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleStrings[currentIndex]),
      ),
      drawer: NavDrawer(onTabTapped, titleStrings),
      body: currentChildren[currentIndex],

    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}




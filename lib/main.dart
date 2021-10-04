import 'package:contact_tracing/NavDrawer.dart';
import 'package:contact_tracing/ProximityTasks/BluetoothProximityDetection.dart';
import 'package:contact_tracing/ProximityTasks/SoundProximityDetection.dart';
import 'package:contact_tracing/ProximityTasks/WifiProximityDetection.dart';
import 'package:flutter/material.dart';
import 'package:contact_tracing/staticPages/ProximityDetectionPage.dart';
import 'package:contact_tracing/staticPages/BlockchainSyncPage.dart';
import 'package:contact_tracing/staticPages/SettingsPage.dart';

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
    ),
    ProximityDetectionPage(
      onButtonPressed: WifiProximityDetection.instance.printStuff,
      checkStarted: () {return false;},
    ),
    ProximityDetectionPage(
      onButtonPressed: SoundProximityDetection.instance.printStuff,
      checkStarted: () {return false;},
    ),
    BlockchainSyncPage(),
  ];
  List<String> titleStrings = [
    "Bluetooth Proximity Detection",
    "Wifi Proximity Detection",
    "Sound Proximity Detection",
    "Blockchain Sync",
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




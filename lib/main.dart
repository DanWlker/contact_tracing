import 'package:contact_tracing/NavDrawer.dart';
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
    ProximityDetectionPage(),
    BlockchainSyncPage(),
    SettingsPage(),
  ];
  List<String> titleStrings = [
    "Proximity Detection",
    "Blockchain Sync",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleStrings[currentIndex]),
      ),
      drawer: NavDrawer(onTabTapped),
      body: currentChildren[currentIndex],

    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}




import 'package:flutter/material.dart';

class ProximityDetectionPage extends StatefulWidget {
  const ProximityDetectionPage({Key? key}) : super(key: key);

  @override
  _ProximityDetectionPageState createState() => _ProximityDetectionPageState();
}

class _ProximityDetectionPageState extends State<ProximityDetectionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Proximity Detection Page"),
      ),
    );
  }
}


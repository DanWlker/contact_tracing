import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> usingBWS = [false, false, false];
  List<String> labelBWS = ["Bluetooth", "Wifi", "Sound"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Enable/Disable Scanning",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          Expanded(
              child: ListView(
                children: generateAllToggles(),
              )
          )
        ],
      ),
    );
  }

  List<Widget> generateAllToggles() {
    List<Widget> temp = [];

    for(int i = 0; i < labelBWS.length; ++i) {
      temp.add(generateToggleFor(i));
    }

    return temp;
  }

  ListTile generateToggleFor(int index) {
    return ListTile(
      title: Text(
        labelBWS[index],
        style: TextStyle(fontSize: 20),
      ),
      trailing: Switch(
        value: usingBWS[index],
        onChanged: (value) {
          setState(() {
            usingBWS[index] = value;
          });
        },
        activeTrackColor: Colors.lightBlue,
        activeColor: Colors.lightBlueAccent,
      ),
    );
  }
}

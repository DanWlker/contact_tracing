import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double progressValue = 0.75;
  int riskIndex = 3;
  String riskText = "Moderate Risk";
  MaterialColor progressColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return HomePageParts();
  }

  Widget HomePageParts() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          SizedBox(height: 15),
          Center(
            child: Text(
                'Risk Index',
                style: TextStyle(fontSize: 30),
              ),
          ),
          SizedBox(height:20),
          progressIndicator(),
          SizedBox(height:15),
          Text("Hello world")
        ]
      ),
    );
  }

  Widget progressIndicator() {
    return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            child: CircularProgressIndicator(
              strokeWidth: 15,
              value: progressValue,
              color: progressColor,
            ),
          ),
          Column(
              children:<Widget>[
                Text(riskIndex.toString(), style: TextStyle(fontSize: 60),),
                Text(riskText, style:TextStyle(fontSize: 20))
              ]
          )
        ]
    );
  }
}

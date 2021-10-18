import 'package:flutter/material.dart';

class ProximityDetectionPage extends StatefulWidget {
  final Function onButtonPressed;
  final Function checkStarted;
  final Function disposeMethod;

  const ProximityDetectionPage({Key? key, required this.onButtonPressed, required this.checkStarted, required this.disposeMethod}) : super(key: key);

  @override
  _ProximityDetectionPageState createState() => _ProximityDetectionPageState();
}

class _ProximityDetectionPageState extends State<ProximityDetectionPage> {
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Scanned Devices",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: generateLists(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton.extended(
                  onPressed: (){
                    widget.onButtonPressed(context);

                    if(widget.checkStarted()) {
                      setState(() {
                        isRunning = true;
                      });
                    } else {
                      setState(() {
                        isRunning = false;
                      });
                    }

                    },
                  tooltip: 'Filter',
                  icon: Icon(
                          Icons.arrow_right_sharp,
                          size: 40,
                        ),
                  label: isRunning? Text("Stop proximity detection"): Text("Start proximity detection"),
                ),
              ],
            )
        )
      ],
    );
  }

  List<Widget> generateLists() {
    List<Widget> temp = [];
    for(int i = 0; i < 15; ++i) {
      temp.add(returnExample());
    }
    return temp;
  }

  ListTile returnExample() {
    return ListTile(
      title: Text('Three-line ListTile'),
      subtitle: Text(
          'A sufficiently long subtitle warrants three lines.'
      ),

      isThreeLine: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.disposeMethod();
  }
}


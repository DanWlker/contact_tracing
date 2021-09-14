import 'package:flutter/material.dart';

class ProximityDetectionPage extends StatefulWidget {
  final Function onButtonPressed;

  const ProximityDetectionPage({Key? key, required this.onButtonPressed}) : super(key: key);

  @override
  _ProximityDetectionPageState createState() => _ProximityDetectionPageState();
}

class _ProximityDetectionPageState extends State<ProximityDetectionPage> {
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
            child: FloatingActionButton.extended(
              onPressed: (){
                //@Todo implement show filter options on button press
                widget.onButtonPressed();
                },
              tooltip: 'Filter',
              icon: Icon(
                      Icons.arrow_right_sharp,
                      size: 40,
                    ),
              label: Text("Start proximity detection"),
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
}


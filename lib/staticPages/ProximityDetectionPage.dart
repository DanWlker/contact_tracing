import 'package:flutter/material.dart';

class ProximityDetectionPage extends StatefulWidget {
  const ProximityDetectionPage({Key? key}) : super(key: key);

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
            child: FloatingActionButton(
              onPressed: (){
                //@Todo implement show filter options on button press
                },
              tooltip: 'Filter',
              child: Icon(Icons.settings),
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


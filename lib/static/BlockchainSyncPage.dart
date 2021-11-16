import 'package:contact_tracing/utilities/HttpHelper.dart';
import 'package:flutter/material.dart';

class BlockchainSyncPage extends StatefulWidget {
  const BlockchainSyncPage({Key? key}) : super(key: key);

  @override
  _BlockchainSyncPageState createState() => _BlockchainSyncPageState();
}

class _BlockchainSyncPageState extends State<BlockchainSyncPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Sync to address: "
                ),
                controller: myController,
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                    "Matches Found:",
                    style: TextStyle(fontSize: 20)
                  )
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: generateLists(),
                )
              )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
             onPressed: () {
               //@Todo implment sync on button press
               HttpHelper.instance.uploadEncounters(myController.text);
             },
              icon: Icon(Icons.sync),
              label: Text("Tap to sync"),
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

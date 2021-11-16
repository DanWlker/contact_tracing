import 'package:contact_tracing/entity/Block.dart';
import 'package:contact_tracing/entity/Case.dart';
import 'package:contact_tracing/entity/IndvCloseContact.dart';
import 'package:contact_tracing/utilities/HttpHelper.dart';
import 'package:flutter/material.dart';

class BlockchainSyncPage extends StatefulWidget {
  const BlockchainSyncPage({Key? key}) : super(key: key);

  @override
  _BlockchainSyncPageState createState() => _BlockchainSyncPageState();
}

class _BlockchainSyncPageState extends State<BlockchainSyncPage> {
  final addressController = TextEditingController();
  final signatureController = TextEditingController();
  final identifierController = TextEditingController();
  List<Widget> matchesFound = [];

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
                controller: addressController,
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Doctor Signature: "
                ),
                controller: signatureController,
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Identifier to find: "
                ),
                controller: identifierController,
              ),
              SizedBox(
                height: 45,
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
                  children: matchesFound,
                )
              )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {
                    HttpHelper.instance.downloadEncounters(
                        addressController.text,
                        identifierController.text,
                        generateListsAfterRetrieving
                    );
                  },
                  icon: Icon(Icons.sync),
                  label: Text("Tap to sync"),
                ),
                SizedBox(height:15),
                FloatingActionButton.extended(
                 onPressed: () {
                   HttpHelper.instance.uploadEncounters(addressController.text, signatureController.text);
                 },
                  icon: Icon(Icons.sync),
                  label: Text("Tap to upload"),
                ),
              ],
            )
        )

      ],
    );
  }

  void generateListsAfterRetrieving(List<Block> searchItems, String identifierToFind) {
    matchesFound.clear();

    List<Widget> temp = [];

    for(Block blockItem in searchItems) {
      for(Case caseItem in blockItem.ledger) {
        for(IndvCloseContact contactItem in caseItem.recordedCases){
          if(contactItem.closeContactIdentifier == identifierToFind) {
            temp.add(cardBuilder(contactItem));
          }
        }
      }
    }

    setState((){
      matchesFound = temp;
    });
  }

  Card cardBuilder(IndvCloseContact contactInfo) {
    return Card(
        child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                generateRichText("ID: ", contactInfo.closeContactIdentifier),
                generateRichText("Contact Date and Time: ", contactInfo.dateOfContact),
                generateRichText("Detected by: ", contactInfo.mediumOfDetection.toString()),
                generateRichText("Estimated Duration: ", contactInfo.estimatedDurationOfContact)
              ],
            ),
        )
    );
  }

  Text generateRichText(String label, String value) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5)
          ),
          TextSpan(
              text: value,
              style: TextStyle(fontSize: 14.5)
          )
        ],
      ),
    );
  }
}

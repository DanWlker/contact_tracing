import 'package:contact_tracing/utilities/SQLiteHelper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQLTestingPage extends StatefulWidget {
  const SQLTestingPage({Key? key}) : super(key: key);

  @override
  _SQLTestingPageState createState() => _SQLTestingPageState();
}

class _SQLTestingPageState extends State<SQLTestingPage> {
  double boxHeight = 30;
  List<String> fields = [
    'CloseContactIdentifier',
    'DateOfContact',
    'DistanceOfContactMetres',
    'MediumOfDetection',
    'EstimatedDurationOfContact',
    'id'
  ];
  List<TextEditingController> textEditingControllers = List.generate(6, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Column(
            children: generateFields()
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  Database db = await SQLiteHelper.instance.getDatabase();
                  await db.rawQuery('''
                  insert into CloseContactList(closecontactidentifier, dateofcontact, distanceofcontactmetres, mediumofdetection, estimateddurationofcontact) 
                  values (
                  "${textEditingControllers[0].text}",
                  "${textEditingControllers[1].text}",
                  "${textEditingControllers[2].text}",
                  "${textEditingControllers[3].text}",
                  "${textEditingControllers[4].text}"
                  )
                  ''');
                },
                child: Text("Insert"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue
                ),
              ),
              SizedBox(width:30),
              TextButton(
                onPressed: () async {
                  Database db = await SQLiteHelper.instance.getDatabase();
                  var resultSet = await db.rawQuery('''
                  select * from CloseContactList where id = ${textEditingControllers[5].text}
                  ''');
                  var dbItem = resultSet.first;
                  String finalText = "";
                  for(var item in dbItem.values) {
                    finalText = finalText + item.toString() + " ";
                  }
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                    title: Text('Result for id = ${textEditingControllers[5].text}'),
                    content: Text(finalText),
                      )
                  );
                },
                child: Text("Retrieve"),
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue
                ),
              ),

            ],
          )
        ],
      ),
    );
  }

  List<Widget> generateFields() {
    List<Widget> result = [];

    for(int i = 0; i < fields.length; ++i) {
      result.add(
          TextField(
              decoration: InputDecoration(
                  labelText: fields[i],
              ),
              controller: textEditingControllers[i]
          )
      );
      result.add(
        SizedBox(height: boxHeight)
      );
    }

    return result;
  }
}

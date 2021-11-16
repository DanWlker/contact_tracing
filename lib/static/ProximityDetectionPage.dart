import 'package:contact_tracing/utilities/SQLiteHelper.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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

  final int increment = 10;
  bool isLoading = false;
  List<Map> data = [];
  int currentLength = 0;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
     setState((){
       isLoading = true;
     });

     //load stuff from sql
     data += await SQLiteHelper.instance.getRecordsFrom(data.length);

     setState((){
       isLoading = false;
       currentLength = data.length;
     });
  }

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
              SizedBox(height:15),
              Expanded(
                child: LazyLoadScrollView(
                  isLoading: isLoading,
                  onEndOfPage: () => _loadMore(),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, position) {
                      return cardBuilder(position);
                    }
                  )
                ),
              ),
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
                  onPressed: (){
                    data.clear();
                    setState((){
                      _loadMore();
                    });
                  },
                  tooltip: 'Filter',
                  icon: Icon(
                    Icons.refresh,
                    size: 25,
                  ),
                  label: Text("Refresh"),
                ),
                SizedBox(height:15),
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
                          size: 45,
                        ),
                  label: isRunning? Text("Stop"): Text("Start"),
                ),

              ],
            )
        )
      ],
    );
  }

  Card cardBuilder(int position) {
    return Card(
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                SQLiteHelper.instance.deleteRecord(data[position]["CloseContactIdentifier"]);
                data.clear();
                setState((){
                  _loadMore();
                });
              },
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                generateRichText("ID: ", data[position]["CloseContactIdentifier"]),
                generateRichText("Contact Date and Time: ", data[position]["DateOfContact"]),
                generateRichText("Detected by: ", data[position]["MediumOfDetection"]),
                generateRichText("Estimated Duration: ", data[position]["EstimatedDurationOfContact"])
              ],
            ),

          ],
        )
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

  @override
  void dispose() {
    super.dispose();
    widget.disposeMethod();
  }
}


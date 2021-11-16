import 'dart:convert';
import 'package:contact_tracing/entity/Case.dart';
import 'package:contact_tracing/entity/IndvCloseContact.dart';
import 'package:contact_tracing/utilities/MockDoctorSignature.dart';
import 'package:contact_tracing/utilities/SQLiteHelper.dart';
import 'package:contact_tracing/utilities/UserInfo.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static HttpHelper instance = HttpHelper();

  Future<void> uploadEncounters(String address) async {

    List<Map> allRecords = await SQLiteHelper.instance.returnAllRecordsAfter(
        DateTime.now().subtract(const Duration(days:14))
    );

    List<IndvCloseContact> tempList = [];
    for(var items in allRecords) {
      tempList.add(
          IndvCloseContact(
              items['CloseContactIdentifier'],
              items['DateOfContact'],
              items['DistanceOfContactMetres'] ?? "-",
              items['MediumOfDetection'].split(','),
              items['EstimatedDurationOfContact'] ?? "-"
          )
      );
    }
    
    Case newCase = Case(
      UserInfo.instance.userName,
      tempList,
      MockDoctorSignature.signature
    );

    String newCaseJson = newCase.toJson().toString();
    print(newCaseJson);

    // return http.post(
    //   Uri.parse(address),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'title': 'Hello world',
    //   }
    //   ),
    // );
  }

}
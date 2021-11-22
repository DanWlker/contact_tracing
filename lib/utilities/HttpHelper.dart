import 'dart:convert';
import 'package:contact_tracing/entity/Block.dart';
import 'package:contact_tracing/entity/BlockchainUpCommWrapper.dart';
import 'package:contact_tracing/entity/Case.dart';
import 'package:contact_tracing/entity/IndvCloseContact.dart';
import 'package:contact_tracing/utilities/CryptoHelper.dart';
import 'package:contact_tracing/utilities/SQLiteHelper.dart';
import 'package:contact_tracing/utilities/UserInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static HttpHelper instance = HttpHelper();

  Future<http.Response> uploadEncounters(String address, String signature) async {

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
      signature
    );

    print(CryptoHelper.instance.getPublicKey());

    String newCaseJson = jsonEncode(newCase).toString();
    print(newCaseJson);

    Map<String, dynamic> signatureFormat = {
      "type": "Buffer",
      "data": CryptoHelper.instance.signThis(newCaseJson).toList()
    };

    print(signatureFormat.toString());

    BlockchainUpCommWrapper wrapper =
      BlockchainUpCommWrapper(
          CryptoHelper.instance.getPublicKey(),
          newCase,
          signatureFormat
      );

    return http.post(
      Uri.parse(address+"/insertCase"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(wrapper.toJson()),
    );
  }

  Future<void> downloadEncounters(String address, String identifierToFind, Function loader) async {
    final response = await http.get(Uri.parse(address+"/getAllCases"));
    List<Block> tempList = [];

    for(var item in json.decode(response.body)) {
      tempList.add(Block.fromJson(item));
    }

    loader(tempList, identifierToFind);
  }

}
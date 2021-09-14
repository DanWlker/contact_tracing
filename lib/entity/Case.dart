import 'IndvCloseContact.dart';

class Case {
  String? uploadedDeviceIdentifier;
  List<IndvCloseContact>? recordedCases;
  String? signee;

  Case({this.uploadedDeviceIdentifier, this.recordedCases, this.signee});

  Case.fromJson(Map<String, dynamic> json) {
    uploadedDeviceIdentifier = json['uploadedDeviceIdentifier'];
    if (json['recordedCases'] != null) {
      recordedCases = [];
      json['recordedCases'].forEach((v) {
        recordedCases!.add(new IndvCloseContact.fromJson(v));
      });
    }
    signee = json['signee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDeviceIdentifier'] = this.uploadedDeviceIdentifier;
    if (this.recordedCases != null) {
      data['recordedCases'] =
          this.recordedCases!.map((v) => v.toJson()).toList();
    }
    data['signee'] = this.signee;
    return data;
  }
}



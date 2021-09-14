import 'package:json_annotation/json_annotation.dart';

import 'IndvCloseContact.dart';

part 'Case.g.dart';

@JsonSerializable(explicitToJson: true)
class Case {
  String uploadedDeviceIdentifier;
  List<IndvCloseContact> recordedCases;
  String signee;

  Case(
      this.uploadedDeviceIdentifier,
      this.recordedCases,
      this.signee);

  factory Case.fromJson(Map<String, dynamic> json) => _$CaseFromJson(json);

  Map<String, dynamic> toJson() => _$CaseToJson(this);
}



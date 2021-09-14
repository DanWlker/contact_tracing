// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Case _$CaseFromJson(Map<String, dynamic> json) => Case(
      json['uploadedDeviceIdentifier'] as String,
      (json['recordedCases'] as List<dynamic>)
          .map((e) => IndvCloseContact.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['signee'] as String,
    );

Map<String, dynamic> _$CaseToJson(Case instance) => <String, dynamic>{
      'uploadedDeviceIdentifier': instance.uploadedDeviceIdentifier,
      'recordedCases': instance.recordedCases.map((e) => e.toJson()).toList(),
      'signee': instance.signee,
    };

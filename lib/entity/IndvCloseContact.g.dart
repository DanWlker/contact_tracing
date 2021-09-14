// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IndvCloseContact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndvCloseContact _$IndvCloseContactFromJson(Map<String, dynamic> json) =>
    IndvCloseContact(
      json['closeContactIdentifier'] as String,
      json['dateOfContact'] as String,
      json['distanceOfContactMetres'] as String,
      (json['mediumOfDetection'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['estimatedDurationOfContact'] as String,
    );

Map<String, dynamic> _$IndvCloseContactToJson(IndvCloseContact instance) =>
    <String, dynamic>{
      'closeContactIdentifier': instance.closeContactIdentifier,
      'dateOfContact': instance.dateOfContact,
      'distanceOfContactMetres': instance.distanceOfContactMetres,
      'mediumOfDetection': instance.mediumOfDetection,
      'estimatedDurationOfContact': instance.estimatedDurationOfContact,
    };

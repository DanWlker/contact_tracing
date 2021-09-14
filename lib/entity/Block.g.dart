// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      json['prevHash'] as String,
      json['time'] as String,
      json['nonce'] as int,
      (json['ledger'] as List<dynamic>)
          .map((e) => Case.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'prevHash': instance.prevHash,
      'time': instance.time,
      'nonce': instance.nonce,
      'ledger': instance.ledger.map((e) => e.toJson()).toList(),
    };

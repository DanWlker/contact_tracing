// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BlockchainUpCommWrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockchainUpCommWrapper _$BlockchainUpCommWrapperFromJson(
        Map<String, dynamic> json) =>
    BlockchainUpCommWrapper(
      json['publicKey'] as String,
      Case.fromJson(json['ledger'] as Map<String, dynamic>),
      json['signature'] as String,
    );

Map<String, dynamic> _$BlockchainUpCommWrapperToJson(
        BlockchainUpCommWrapper instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'ledger': instance.ledger.toJson(),
      'signature': instance.signature,
    };

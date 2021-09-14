import 'package:json_annotation/json_annotation.dart';

import 'Case.dart';

part 'BlockchainUpCommWrapper.g.dart';

@JsonSerializable(explicitToJson: true)
class BlockchainUpCommWrapper {
  String publicKey;
  Case ledger;
  String signature;

  BlockchainUpCommWrapper(
      this.publicKey,
      this.ledger,
      this.signature);

  factory BlockchainUpCommWrapper.fromJson(Map<String, dynamic> json) => _$BlockchainUpCommWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$BlockchainUpCommWrapperToJson(this);

}
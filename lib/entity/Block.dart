import 'package:json_annotation/json_annotation.dart';

import 'Case.dart';

part 'Block.g.dart';

@JsonSerializable(explicitToJson: true)
class Block{
  String prevHash;
  String time;
  int nonce;
  List<Case> ledger;

  Block(
      this.prevHash,
      this.time,
      this.nonce,
      this.ledger);

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);

  Map<String, dynamic> toJson() => _$BlockToJson(this);

}
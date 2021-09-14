import 'Case.dart';

class Block{
  String? prevHash;
  String? time;
  int? nonce;
  List<Case>? ledger;

  Block(
      {this.prevHash, this.time, this.nonce, this.ledger});

  Block.fromJson(Map<String, dynamic> json) {
    prevHash = json['prevHash'];
    time = json['time'];
    nonce = json['nonce'];
    if (json['ledger'] != null) {
      ledger = [];
      json['ledger'].forEach((v) {
        ledger!.add(new Case.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prevHash'] = this.prevHash;
    data['time'] = this.time;
    data['nonce'] = this.nonce;
    if (this.ledger != null) {
      data['ledger'] = this.ledger!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
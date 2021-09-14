import 'Case.dart';

class BlockchainCommunicationWrapper {
  String? publicKey;
  Case? ledger;
  String? signature;

  BlockchainCommunicationWrapper({this.publicKey, this.ledger, this.signature});

  BlockchainCommunicationWrapper.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
    ledger =
    json['ledger'] != null ? new Case.fromJson(json['ledger']) : null;
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicKey'] = this.publicKey;
    if (this.ledger != null) {
      data['ledger'] = this.ledger!.toJson();
    }
    data['signature'] = this.signature;
    return data;
  }
}
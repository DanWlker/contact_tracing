import 'dart:typed_data';

import'package:crypton/crypton.dart';

class MockDoctor {
  static MockDoctor instance = MockDoctor();

  late RSAPublicKey _publicKey;
  late RSAPrivateKey _privateKey;

  MockDoctor() {
    RSAKeypair rsaKeypair = RSAKeypair.fromRandom();
    _publicKey = rsaKeypair.publicKey;
    _privateKey = rsaKeypair.privateKey;
  }

  Uint8List signThis(String message) {
    List<int> list = message.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    return _privateKey.createSHA256Signature(bytes);
  }

  String getPublicKey() {
    return _publicKey.toPEM();
  }
}
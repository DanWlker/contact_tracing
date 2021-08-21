import 'package:flutter/material.dart';

class BlockchainSyncPage extends StatefulWidget {
  const BlockchainSyncPage({Key? key}) : super(key: key);

  @override
  _BlockchainSyncPageState createState() => _BlockchainSyncPageState();
}

class _BlockchainSyncPageState extends State<BlockchainSyncPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Blockchain Sync Page"),
      ),
    );
  }
}

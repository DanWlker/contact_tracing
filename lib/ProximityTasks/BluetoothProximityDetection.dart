
import 'dart:math';

import 'package:contact_tracing/ProximityTasks/ProximityDetection.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';

class BluetoothProximityDetection implements ProximityDetection{
  static BluetoothProximityDetection instance = new BluetoothProximityDetection();
  final Strategy _strategy = Strategy.P2P_CLUSTER;
  bool startedScan = false;

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Bluetooth page");
  }

  void toggleProximityScan(BuildContext context) {
    if(startedScan) {
      _stopProximityScan();
      startedScan = false;
    } else {
      _startProximityScan(context);
      startedScan = true;
    }
  }

  bool getStartStop() {
    return startedScan;
  }

  void _startProximityScan(BuildContext context) async {
    if(! await _getPermissions(context)) {
      return;
    }
    _discover();
    _advertise();
  }

  void _stopProximityScan() {
    Nearby().stopDiscovery();
    Nearby().stopAdvertising();
  }

  void _discover() async {
    try {
      bool a = await Nearby().startDiscovery(
         _getRandomString(5),
          _strategy,
          onEndpointFound:
              (String id, String name, String serviceId) {
            print('Discover found id=$id with name:$name');
          },
          onEndpointLost: (id) {
            print('Discover lost id:$id');
          });
    } catch (e) {
      print(e);
    }
  }

  void _advertise() async {
    try {
      bool a = await Nearby().startAdvertising(
        _getRandomString(5),
        _strategy,
        onConnectionInitiated: (String id, ConnectionInfo info) {
          print("Advertise initiated id=$id");
        },
        onConnectionResult: (String id, Status status){
          print("Advertise resulted id=$id");
        },
        onDisconnected: (String id){
          print("Advertise disconnected id=$id");
        }
      );
    } catch(e) {
      print(e);
    }
  }

  Future<bool> _getPermissions(BuildContext context) async {
    Nearby().askLocationAndExternalStoragePermission();

    //Code below doesn't work for some reason
    // if(! await Nearby().checkLocationPermission()) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("Location permission not granted :)")));
    //   return false;
    // }

    // if(! await Nearby().checkExternalStoragePermission()) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("External storage permission not granted :)")));
    //   return false;
    // }

    // if(! await Nearby().checkLocationEnabled()) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("Location not enabled")));
    //   return false;
    // }

    return true;
  }

  String _getRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }

  @override
  void disposeMethod() {
    // TODO: implement disposeMethod
  }

}
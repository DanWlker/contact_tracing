import 'dart:math';
import 'package:contact_tracing/proximitytasks/ProximityDetection.dart';
import 'package:contact_tracing/utilities/SQLiteHelper.dart';
import 'package:contact_tracing/utilities/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:sqflite/sqflite.dart';

import 'SoundProximityDetection.dart';

class BluetoothProximityDetection implements ProximityDetection{
  static BluetoothProximityDetection instance = new BluetoothProximityDetection();
  final Strategy _strategy = Strategy.P2P_POINT_TO_POINT;
  bool startedScan = false;

  late BuildContext bContext;

  @override
  void printStuff() {
    print("This is the Bluetooth page");
  }

  void toggleProximityScan(BuildContext context) {
    bContext = context;

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
    SoundProximityDetection.instance.disposeMethod();
  }

  void _discover() async {
    try {
      bool a = await Nearby().startDiscovery(
         UserInfo.instance.userName,
          _strategy,
          onEndpointFound:
              (String id, String name, String serviceId) async {
                 //TODO: check if have discovered this before
                  if(await SQLiteHelper.instance.checkDatabaseForUser(name)){
                    if(await SQLiteHelper.instance.soundDiscovered(name)) {
                      print("Sound discovered before");
                      return;
                    }
                  } //if encountered before
                  else
                    await SQLiteHelper.instance.insertIntoDatabase(name, "Bluetooth");

                  // showDialog(
                  //     context: bContext,
                  //     builder: (_) => AlertDialog(
                  //       title: Text('Discover found ${name}'),
                  //       content: Text('Id is ${id}'),
                  //     )
                  // );

                  if(UserInfo.instance.userName.compareTo(name) > 0) { //check if need to request connection
                    return;
                  }

                  Nearby().requestConnection(
                      UserInfo.instance.userName,
                      id,
                      onConnectionInitiated: (str, connInfo){
                        SoundProximityDetection.instance.listenForSignal(bContext, name);

                        Future.delayed(Duration(seconds: 5), () {
                          disconnectMethod();
                        });
                      },
                      onConnectionResult: (id, status){print(status);},
                      onDisconnected: (id){}
                  );


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
          UserInfo.instance.userName,
          _strategy,
          onConnectionInitiated: (String id, ConnectionInfo info) async{
            if(!await SQLiteHelper.instance.checkDatabaseForUser(info.endpointName))
              await SQLiteHelper.instance.insertIntoDatabase(info.endpointName, "Bluetooth");

            devAcceptConnection(id, info);
            Future.delayed(Duration(seconds: 2), () {
              SoundProximityDetection.instance.broadcastSignal(bContext, info.endpointName);
            });


            // showDialog(
            //     context: bContext,
            //     builder: (_) => AlertDialog(
            //       title: Text('Advertise found ${info.endpointName}'),
            //       content: Text('Id is ${id}'),
            //     )
            // );

            //TODO: disconnect or turn off everything after few secs
            Future.delayed(Duration(seconds: 10), () {
              disconnectMethod();
            });
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
    return true;
  }

  @override
  void disposeMethod() {
    // TODO: implement disposeMethod
  }

  void devAcceptConnection(String id, ConnectionInfo info) {
    //save this connection to sql first, then see if need to arrange for broadcast
    Nearby().acceptConnection(
        id,
        onPayLoadRecieved: (endpointId, payload) {
          // called whenever a payload is recieved.
        },
        onPayloadTransferUpdate: (endpointId, payloadTransferUpdate) {
        // gives status of a payload
        // e.g success/failure/in_progress
        // bytes transferred and total bytes etc
        }
    );
  }

  void disconnectMethod() {
    Nearby().stopAllEndpoints();
    SoundProximityDetection.instance.disposeMethod();
    _startProximityScan(bContext);
  }

}
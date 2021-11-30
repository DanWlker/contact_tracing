import 'dart:io';

import 'package:contact_tracing/proximitytasks/ProximityDetection.dart';
import 'package:contact_tracing/utilities/SQLiteHelper.dart';
import 'package:contact_tracing/utilities/SoundListener.dart';
import 'package:contact_tracing/utilities/SoundPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  bool isRunning = false;
  int testsRunned = 0;
  double defaultDecibalLevel = 0;
  late BuildContext bContext;
  late String nameOfUserToCheck;

  @override
  void printStuff() {
    print("This is the Sound page");
  }

  void broadcastSignal(BuildContext context, String nameOfOtherPhone) {
    bContext = context;
    nameOfUserToCheck = nameOfOtherPhone;

    // if(this.defaultDecibalLevel == 0 ) {
    //   startOwnSignalLoudnessTest();
    //   return;
    // }

    this.isRunning = true;
    //TODO:broadcast signal
    SoundPlayer.instance.toggleSignal();
    sleep(Duration(seconds:1));
    SoundPlayer.instance.toggleSignal();
    //TODO:start listening for signal's return
    sleep(Duration(seconds:1));
    SoundListener.instance.toggleListener(this.callbackFunctionForBroadcaster);
  }

  void listenForSignal(BuildContext context, String nameOfOtherPhone) {
    bContext = context;
    nameOfUserToCheck = nameOfOtherPhone;
    // if(this.defaultDecibalLevel == 0) {
    //   startOwnSignalLoudnessTest();
    //   return;
    // }

    this.isRunning = true;
    //start listening for signal
    SoundListener.instance.toggleListener(this.callbackFunctionForListener);// async or smt
  }

  void startOwnSignalLoudnessTest() {
    if(SoundPlayer.instance.getIsPlaying()) {
      SoundPlayer.instance.toggleSignal(); //stop the sound first if playing
    }
    //start to listen
    SoundListener.instance.toggleListener(this.callbackFunctionOwnSignalLoudnessTest);// async or smt
    //Toggle signal to start playing
    SoundPlayer.instance.toggleSignal();
  }

  void stopOwnSignalLoudnessTest() {
    //Toggle signal off
    if(SoundPlayer.instance.getIsPlaying()) {
      SoundPlayer.instance.toggleSignal();
    }

    //stop listening
    if(SoundListener.instance.getIsListening()) {
      SoundListener.instance.toggleListener((){});
    }

    sleep(Duration(seconds:1));

    //repeat the test, i have no idea how to do otherwise so XD
    if(testsRunned == 2) {
      defaultDecibalLevel = defaultDecibalLevel / 3;
      print("Average decibal:" + defaultDecibalLevel.toString());
    } else {
      testsRunned += 1;
      startOwnSignalLoudnessTest();
    }
  }

  @override
  void disposeMethod() {
    SoundListener.instance.dispose();
    SoundPlayer.instance.dispose();
  }

  bool getIsRunning() {
    return this.isRunning;
  }

  void callbackFunctionForBroadcaster(double measuredDecibal) {
    //After measuring noise level, calculate the distance
    //calculateDistance(measuredDecibal);
    SQLiteHelper.instance.updateRow(nameOfUserToCheck, "Bluetooth, Sound", "-");
  }

  void callbackFunctionForListener(double measuredDecibal) {
    //TODO: after that return signal
    int waitDurationSeconds = 2;
    Future.delayed(Duration(seconds: waitDurationSeconds), () {
      // Here you can write your code
      SoundPlayer.instance.toggleSignal();
      sleep(Duration(seconds: 1));
      SoundPlayer.instance.toggleSignal();
    });

    //After returning, calculate distance
    //calculateDistance(measuredDecibal);
    SQLiteHelper.instance.updateRow(nameOfUserToCheck, "Bluetooth, Sound", "-");
  }

  void callbackFunctionOwnSignalLoudnessTest(double measuredDecibal) {
    //After measuring noise level
    defaultDecibalLevel += measuredDecibal;
    stopOwnSignalLoudnessTest();
  }

  void calculateDistance(double measuredDecibal) {
    showDialog(
        context: bContext,
        builder: (_) => AlertDialog(
          title: Text('Result for decibel = ${measuredDecibal}'),
          content: Text('Welp'),
        )
    );
  }
}
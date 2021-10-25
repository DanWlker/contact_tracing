import 'dart:io';

import 'package:contact_tracing/proximitytasks/ProximityDetection.dart';
import 'package:contact_tracing/utilities/SoundListener.dart';
import 'package:contact_tracing/utilities/SoundPlayer.dart';
import 'package:contact_tracing/utilities/StopwatchUtility.dart';
import 'package:flutter/cupertino.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  bool isTesting = false;
  int averageDelayMs = 0;

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Sound page");
  }

  void broadcastSignal(BuildContext context) {
    if(this.averageDelayMs == 0) {
      _testAverageDelay();
    }

    //broadcast signal
    //start listening for signal's return
  }

  void listenForSignal(BuildContext context) {
    if(this.averageDelayMs == 0) {
     this._testAverageDelay();
    }

    //start listening for signal
    SoundListener.instance.toggleListener(this.callbackFunctionForListener);// async or smt
  }

  void _testAverageDelay() {

    for(int i = 0; i < 3; ++i) {
      //start delay test
      this.startInternalDelayTest();

      //wait for 3 secs
      sleep(Duration(seconds:3));

      //stop the test if the function hasn't complete, if complete it will have already been stopped
      this.stopInternalDelayTest();

      //wait for 2 secs
      sleep(Duration(seconds:2));
    }

    //calculate average delay
  }

  void startInternalDelayTest() {
    if(SoundPlayer.instance.getIsPlaying()) {
      SoundPlayer.instance.toggleSignal(); //stop the sound first if playing
    }
    //start to listen
    SoundListener.instance.toggleListener(this.callbackFunctionForInternalDelayTest);// async or smt
    //Start Timer
    StopwatchUtility.instance.stopwatch.start();
    //Toggle signal to start playing
    SoundPlayer.instance.toggleSignal();
  }

  void stopInternalDelayTest() {
    //Toggle signal off
    if(SoundPlayer.instance.getIsPlaying()) {
      SoundPlayer.instance.toggleSignal();
    }

    //stop listening
    if(SoundListener.instance.getIsListening()) {
      SoundListener.instance.toggleListener((){});
    }
    //stop stopwatch
    if(StopwatchUtility.instance.stopwatch.isRunning) {
      StopwatchUtility.instance.stopwatch.stop();
      StopwatchUtility.instance.stopwatch.reset();
    }
  }

  @override
  void disposeMethod() {
    SoundListener.instance.dispose();
    SoundPlayer.instance.dispose();
  }

  bool getIsTesting() {
    return this.isTesting;
  }

  void callbackFunctionForBroadcaster() { //we don't actually use this variable

  }

  void callbackFunctionForListener() {

  }

  void callbackFunctionForInternalDelayTest() {
    this.averageDelayMs += StopwatchUtility.instance.stopwatch.elapsedMilliseconds;
    stopInternalDelayTest();
  }
}
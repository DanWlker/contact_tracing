import 'dart:io';

import 'package:contact_tracing/proximitytasks/ProximityDetection.dart';
import 'package:contact_tracing/utilities/SoundListener.dart';
import 'package:contact_tracing/utilities/SoundPlayer.dart';
import 'package:contact_tracing/utilities/StopwatchUtility.dart';
import 'package:flutter/cupertino.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  bool isRunning = false;
  int averageDelayMs = 0;

  @override
  void printStuff() {
    print("This is the Sound page");
  }

  void broadcastSignal(BuildContext context) {
    if(this.averageDelayMs == 0) {
      //TODO:maybe make a pop up or smt here to indicate it is self synchronizing
      _testAverageDelay();
      return;
    }

    this.isRunning = true;
    //TODO:broadcast signal
    //TODO:start listening for signal's return
  }

  void listenForSignal(BuildContext context) {
    if(this.averageDelayMs == 0) {
      //TODO:maybe make a pop up or smt here to indicate it is self synchronizing
     this._testAverageDelay();
     return;
    }

    this.isRunning = true;
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

    //TODO:calculate average delay by dividing the total of the average by 3
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

  bool getIsRunning() {
    return this.isRunning;
  }

  void callbackFunctionForBroadcaster() {
    //TODO:start calculating the distance between two ppl
  }

  void callbackFunctionForListener() {
    //TODO:wait for a few seconds minus the delay and broadcast the return signal
  }

  void callbackFunctionForInternalDelayTest() {
    this.averageDelayMs += StopwatchUtility.instance.stopwatch.elapsedMilliseconds;
    stopInternalDelayTest();
  }
}
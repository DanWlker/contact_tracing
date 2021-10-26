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
  int testsRunned = 0;

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
    StopwatchUtility.instance.stopwatch.start();
    //TODO:broadcast signal
    SoundPlayer.instance.toggleSignal();
    sleep(Duration(seconds:1));
    SoundPlayer.instance.toggleSignal();
    //TODO:start listening for signal's return
    SoundListener.instance.toggleListener(this.callbackFunctionForBroadcaster);
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
    this.startInternalDelayTest();
    //
    // for(int i = 0; i < 3; ++i) {
    //   //start delay test
    //   this.startInternalDelayTest();
    //
    //   //wait for 3 secs
    //   sleep(Duration(seconds:3));
    //
    //   //stop the test if the function hasn't complete, if complete it will have already been stopped
    //   this.stopInternalDelayTest();
    //
    //   //wait for 2 secs
    //   sleep(Duration(seconds:2));
    // }

    // //TODO:calculate average delay by dividing the total of the average by 3
    // averageDelayMs = averageDelayMs ~/ 3;

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

    sleep(Duration(seconds:1));

    //repeat the test, i have no idea how to do otherwise so XD
    if(testsRunned == 2) {
      averageDelayMs = averageDelayMs ~/ 3;
      print("Average delay:" + averageDelayMs.toString());
    } else {
      testsRunned += 1;
      _testAverageDelay();
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
    int totalTime = StopwatchUtility.instance.stopwatch.elapsedMicroseconds;
    StopwatchUtility.instance.stopwatch.stop();
    StopwatchUtility.instance.stopwatch.reset();
    int actualTime = totalTime - averageDelayMs - 6000000; //minus the internal delay and predefined time to wait
    print("Time elapsed in microseconds = " + actualTime.toString());
    double estimatedDistanceInMetres = (actualTime * 0.000343)/2; //speed of sound is 343m/s, which is 0.343m/mcs
    print("Estimated distance = " + estimatedDistanceInMetres.toString());
  }

  void callbackFunctionForListener() {
    print("listener has heard pitch");
    //TODO:wait for a few seconds minus the delay and broadcast the return signal
    int waitDurationMicroseconds = 6000000 - averageDelayMs; //predefined time to wait
    Future.delayed(Duration(microseconds: waitDurationMicroseconds), () {
      // Here you can write your code
      SoundPlayer.instance.toggleSignal();
      sleep(Duration(seconds: 1));
      SoundPlayer.instance.toggleSignal();
    });
  }

  void callbackFunctionForInternalDelayTest() {
    int delayedTime = StopwatchUtility.instance.stopwatch.elapsedMicroseconds;
    this.averageDelayMs += delayedTime;
    stopInternalDelayTest();
  }
}
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
    StopwatchUtility.instance.stopwatch.start();
    //TODO:broadcast signal
    SoundPlayer.instance.toggleSignal();
    sleep(Duration(seconds:1));
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
    averageDelayMs = averageDelayMs ~/ 3;
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
    int totalTime = StopwatchUtility.instance.stopwatch.elapsedMilliseconds;
    StopwatchUtility.instance.stopwatch.stop();
    StopwatchUtility.instance.stopwatch.reset();
    int actualTime = totalTime - averageDelayMs - 6000; //minus the internal delay and predefined time to wait
    double estimatedDistanceInMetres = actualTime * 0.343; //speed of sound is 343m/s, which is 0.343m/ms
    print(estimatedDistanceInMetres);
  }

  void callbackFunctionForListener() {
    //TODO:wait for a few seconds minus the delay and broadcast the return signal
    int waitDurationMilliseconds = 6000 - averageDelayMs; //predefined time to wait

    Future.delayed(Duration(milliseconds: waitDurationMilliseconds), () {
      // Here you can write your code
      SoundPlayer.instance.toggleSignal();
      sleep(Duration(seconds: 1));
      SoundPlayer.instance.toggleSignal();
    });
  }

  void callbackFunctionForInternalDelayTest() {
    this.averageDelayMs += StopwatchUtility.instance.stopwatch.elapsedMilliseconds;
    stopInternalDelayTest();
  }
}
import 'package:contact_tracing/ProximityTasks/ProximityDetection.dart';
import 'package:contact_tracing/SoundStuff/SoundListener.dart';
import 'package:contact_tracing/SoundStuff/SoundPlayer.dart';
import 'package:contact_tracing/Stopwatch/StopwatchUtility.dart';
import 'package:flutter/cupertino.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  bool isTesting = false;

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Sound page");
  }

  void toggleInternalDelayTest(BuildContext context) {
    if(this.isTesting) {
      stopInternalDelayTest();
      this.isTesting = false;
    } else {
      startInternalDelayTest();
      this.isTesting = true;
    }
  }

  void startInternalDelayTest() {
    //start to listen
    SoundListener.instance.toggleListener();// async or smt
    //Start Timer
    StopwatchUtility.instance.stopwatch.start();
    //Toggle signal
    SoundPlayer.instance.toggleSignal();
  }

  void stopInternalDelayTest() {
    //Toggle signal off
    SoundPlayer.instance.toggleSignal();
    SoundListener.instance.toggleListener();
  }

  @override
  void disposeMethod() {
    // TODO: implement disposeMethod
    SoundListener.instance.dispose();
    SoundPlayer.instance.dispose();
  }

  bool getIsTesting() {
    return this.isTesting;
  }

}
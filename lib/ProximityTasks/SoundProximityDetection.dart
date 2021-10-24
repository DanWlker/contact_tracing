import 'package:contact_tracing/ProximityTasks/ProximityDetection.dart';
import 'package:contact_tracing/SoundStuff/SoundPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  Stopwatch stopwatch = new Stopwatch();

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Sound page");
  }


  void startDetectInternalDelay(BuildContext context) {
    //start to listen
    //listenForSignal();// async or smt
    //Start Timer
    stopwatch.start();
    //Toggle signal
    SoundPlayer.instance.toggleSignalOnOff();

  }

  void stopDetectInternalDelay(BuildContext context) {
    //after listening and processing

    if(true && stopwatch.isRunning) { //if the frequency is correct or smt
      //print amount of internal delay using dialog
      print(stopwatch.elapsedMicroseconds);
      //stop timer
      stopwatch.stop();
      stopwatch.reset();
    }

    //Toggle signal off
    SoundPlayer.instance.toggleSignalOnOff();
  }

  @override
  void disposeMethod() {
    // TODO: implement disposeMethod
  }

}
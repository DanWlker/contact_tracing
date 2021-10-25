import 'package:contact_tracing/proximitytasks/ProximityDetection.dart';
import 'package:contact_tracing/utilities/SoundListener.dart';
import 'package:contact_tracing/utilities/SoundPlayer.dart';
import 'package:contact_tracing/utilities/StopwatchUtility.dart';
import 'package:flutter/cupertino.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  bool isTesting = false;
  double averageDelayMs = 0;

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Sound page");
  }

  void toggleInternalDelayTest(BuildContext context) {
    if(averageDelayMs == 0) {
      _testAverageDelay();
    }

    if(this.isTesting) {
      stopInternalDelayTest();
      this.isTesting = false;
    } else {
      startInternalDelayTest();
      this.isTesting = true;
    }
  }

  void _testAverageDelay() {
    List<double> values = [];

    for(int i = 0; i < 3; ++i) {
      //start delay test
      this.startInternalDelayTest();

      //wait for 3 secs


      //stop the test
      this.stopInternalDelayTest();

      //wait for 2 secs
    }

    //calculate average delay
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
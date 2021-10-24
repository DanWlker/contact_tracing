import 'package:contact_tracing/ProximityTasks/ProximityDetection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  bool isPlaying = false;
  Stopwatch stopwatch = new Stopwatch();

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Sound page");
  }

  bool getIsPlaying() {
    return this.isPlaying;
  }

  void startDetectInternalDelay(BuildContext context) {
    //start to listen
    listenForSignal();// async or smt
    //Start Timer
    stopwatch.start();
    //Toggle signal
    toggleSignalOnOff(context);

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
    toggleSignalOnOff(context);
  }

  void toggleSignalOnOff(BuildContext context) {
    double frequency = 440;
    double balance = 0;
    double volume = 1;
    waveTypes waveType = waveTypes.SINUSOIDAL;
    int sampleRate = 96000;

    SoundGenerator.init(sampleRate);
    SoundGenerator.setFrequency(frequency);
    SoundGenerator.setWaveType(waveType);
    SoundGenerator.setBalance(balance);
    SoundGenerator.setVolume(volume);

    if(this.isPlaying) {
      SoundGenerator.stop();
      this.isPlaying = false;
    } else {
      SoundGenerator.play();
      this.isPlaying = true;
    }
  }

  void listenForSignal() {
    //start listener and what not
  }

  @override
  void disposeMethod() {
    SoundGenerator.release();
  }

}
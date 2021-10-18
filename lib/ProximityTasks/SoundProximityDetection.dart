import 'package:contact_tracing/ProximityTasks/ProximityDetection.dart';
import 'package:flutter/cupertino.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();
  bool isPlaying = false;

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Sound page");
  }

  bool getIsPlaying() {
    return this.isPlaying;
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

  @override
  void disposeMethod() {
    SoundGenerator.release();
  }

}
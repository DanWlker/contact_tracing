import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class SoundPlayer {
  static SoundPlayer instance = new SoundPlayer();
  bool isPlaying = false;

  void toggleSignal() {
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

  bool getIsPlaying() {
    return this.isPlaying;
  }

  void dispose() {
    SoundGenerator.release();
  }
}
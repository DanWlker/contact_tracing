import 'dart:typed_data';

import 'package:contact_tracing/Stopwatch/StopwatchUtility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

class SoundListener {
  static SoundListener instance = new SoundListener();
  bool isListening = false;
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);

  void toggleListener() {
    if(isListening) {
      _stopCapture();
      this.isListening = false;
    } else {
      _startCapture();
      this.isListening = true;
    }
  }

  void dispose() {
    //Ntg i think for now
  }

  bool getIsListening() {
    return this.isListening;
  }

  Future<void> _startCapture() async {
    await _audioRecorder.start(whenAudioFound, onError,
        sampleRate: 44100, bufferSize: 3000);
    print("Sound capture started");
  }

  Future<void> _stopCapture() async {
    await _audioRecorder.stop();
    print("Sound capture stopped");
  }

  void onError(Object e) {
    print(e);
  }

  void whenAudioFound(dynamic obj) {
    //Gets the audio sample
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> audioSample = buffer.toList();

    //Uses pitch_detector_dart library to detect a pitch from the audio sample
    final result = pitchDetectorDart.getPitch(audioSample);

    //after listening and processing
    if(
      result.pitch <= 447 &&
      result.pitch >= 438 &&
      StopwatchUtility.instance.stopwatch.isRunning
    ) { //if the frequency is correct or smt
      print(StopwatchUtility.instance.stopwatch.elapsedMilliseconds);
      //stop timer
      StopwatchUtility.instance.stopwatch.stop();
      StopwatchUtility.instance.stopwatch.reset();
    }
  }

}
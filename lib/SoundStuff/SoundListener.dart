import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

class SoundListener {
  static SoundListener instance = new SoundListener();
  bool isListening = false;

  void checkPitchForAudio(List<double> audioSample) {
    final pitchDetectorDart = PitchDetector(44100, 2000);
    final result = pitchDetectorDart.getPitch(audioSample);
    print(result.pitch);
  }

  void startListener() {

  }

  void dispose() {
    //Ntg i think for now
  }

  bool getIsListening() {
    return this.isListening;
  }

  Future<void> _startCapture() async {
    final _audioRecorder = FlutterAudioCapture();
    await _audioRecorder.start(listener, onError,
        sampleRate: 44100, bufferSize: 3000);
  }

  void onError(Object e) {
    print(e);
  }

  void listener(dynamic obj) {

  }

}
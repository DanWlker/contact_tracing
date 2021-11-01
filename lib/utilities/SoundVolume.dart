import 'dart:async';
import 'package:noise_meter/noise_meter.dart';

class SoundVolume {
  static SoundVolume instance = new SoundVolume();
  bool _isRecording = false;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  Function callbackFunction = () {};

  SoundVolume() {
    this._noiseMeter = new NoiseMeter(onError);
  }

  void onError(Object error) {
    print(error.toString());
    _isRecording = false;
  }

  void start(Function passedCallbackFunction) async {
    try {
      this.callbackFunction = passedCallbackFunction;
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (exception) {
      print(exception);
    }
  }

  void onData(NoiseReading noiseReading) {
      if (!this._isRecording) {
        this._isRecording = true;
      }
    //Do someting with the noiseReading object
      double averageDecibal = noiseReading.meanDecibel;
      stopRecorder();
      print(noiseReading.toString());
      callbackFunction(averageDecibal);
  }

  void stopRecorder() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription?.cancel();
        _noiseSubscription = null;
      }
      this._isRecording = false;
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }
}
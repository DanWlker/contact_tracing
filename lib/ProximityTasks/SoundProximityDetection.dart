import 'package:contact_tracing/ProximityTasks/ProximityDetection.dart';

class SoundProximityDetection implements ProximityDetection{
  static SoundProximityDetection instance = new SoundProximityDetection();

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Sound page");
  }

}
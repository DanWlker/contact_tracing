import 'ProximityDetection.dart';

class WifiProximityDetection implements ProximityDetection {
  static WifiProximityDetection instance = new WifiProximityDetection();

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Wifi Page");
  }

  @override
  void disposeMethod() {
    // TODO: implement disposeMethod
  }

}
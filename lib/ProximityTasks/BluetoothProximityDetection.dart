
import 'package:contact_tracing/ProximityTasks/ProximityDetection.dart';

class BluetoothProximityDetection implements ProximityDetection{
  static BluetoothProximityDetection instance = new BluetoothProximityDetection();

  @override
  void printStuff() {
    // TODO: implement printStuff
    print("This is the Bluetooth page");
  }

}
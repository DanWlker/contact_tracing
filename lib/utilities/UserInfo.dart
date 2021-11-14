import 'dart:math';

class UserInfo {
  static UserInfo instance = UserInfo();
  late String userName;

  UserInfo() {
    this.userName = _getRandomString(10);
    print("The userName is ${userName}");
  }

  String _getRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }

}
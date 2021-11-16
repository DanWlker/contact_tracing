import 'dart:math';

class UserInfo {
  static UserInfo instance = UserInfo();
  late String userName;

  UserInfo() {
    this.userName = _getRandomString(10);
    print("The userName is ${userName}");
  }

  String _getRandomString(int len) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(len, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

}
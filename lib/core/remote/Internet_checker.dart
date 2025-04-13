import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetChecker {
  static Future<bool> internetConnection() async {
    bool result = await InternetConnection().hasInternetAccess;
    return result;
  }
}

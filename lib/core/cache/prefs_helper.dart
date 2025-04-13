import 'dart:convert';

import 'package:azkar_app/core/LocationServices/location.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/c_rem_Time.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setButton(bool button) {
    sharedPreferences.setBool('button', button);
  }

  static bool getButton() {
    return sharedPreferences.getBool('button') ?? false;
  }

  static setPrayerTime(NewPrayerTimesEntity entity) async {
    String jsonString = jsonEncode(entity.toJson());
    await sharedPreferences.setString('prayertimes', jsonString);
  }

  static Future<NewPrayerTimesEntity?> getPrayerTime() async {
    String? jsonString = sharedPreferences.getString('prayertimes');
    if (jsonString == null) return null;
    Map<String, dynamic> prayerMap = jsonDecode(jsonString);
    return NewPrayerTimesEntity.fromJson(prayerMap);
  }

  static setLocation(double lat, double long) {
    sharedPreferences.setDouble('lat', lat);
    sharedPreferences.setDouble('long', long);
  }

  static Future<String?> getLocation() async {
    double? lat = sharedPreferences.getDouble('lat');
    double? long = sharedPreferences.getDouble('long');
    if (lat != null && long != null) {
      return getAddressInArabic(lat, long);
    } else {
      return null;
    }
  }

  static setAddress(String address) {
    sharedPreferences.setString('address', address);
  }

  static Future<String?> getAddress() async {
    return sharedPreferences.getString('address');
  }

  static setVibrationSettings(bool enable) {
    sharedPreferences.setBool('vibrationenable', enable);
  }

  static bool getVibrationSettings() {
    return sharedPreferences.getBool('vibrationenable') ?? true;
  }

  static setVibrationSettingsLimit(int limit) {
    sharedPreferences.setInt('vibrationLimit', limit);
  }

  static int getVibrationSettingsLimit() {
    return sharedPreferences.getInt('vibrationLimit') ?? 0;
  }

  static setFontSize(double s) {
    sharedPreferences.setDouble('fontsize', s);
  }

  static double getFontSize() {
    return sharedPreferences.getDouble('fontsize') ?? FontSize.s18;
  }

  static setCRem(CRemTime remTime) async {
    await sharedPreferences.setString('rem_time', remTime.toJson());
    print("CRemTime saved: ${remTime.toJson()}");
  }

  static Future<CRemTime?> getCRem() async{
  
    final String? remTimeJson = sharedPreferences.getString('rem_time');
    if (remTimeJson != null) {
      // Deserialize the JSON back into a CRemTime object
      return CRemTime.fromJson(remTimeJson);
    } else {
      print('No CRemTime saved');
      return null;
    }
  }

  // Retrieve CRemTime from shared preferences
}

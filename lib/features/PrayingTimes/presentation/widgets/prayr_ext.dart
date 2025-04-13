import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/custom_praye_time_model.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as i;
import 'package:lucide_icons/lucide_icons.dart';

IconData getPrayerIcon(String prayer) {
  switch (prayer) {
    case StringsManager.fajr:
      return LucideIcons.sunDim;
    case StringsManager.duhur:
      return LucideIcons.sun;
    case StringsManager.sunrise:
      return LucideIcons.sunrise;
    case StringsManager.asr:
      return LucideIcons.cloudSun;
    case StringsManager.maghrib:
      return LucideIcons.sunset;
    case StringsManager.isha:
      return LucideIcons.moon;
    case StringsManager.firstThird:
      return Icons.nights_stay_outlined;
    case StringsManager.midNight:
      return Icons.twelve_mp_rounded;
    case StringsManager.lastThird:
      return Icons.nights_stay_rounded;
    default:
      return LucideIcons.clock;
  }
}

String getMonthName(int num) {
  switch (num) {
    case 1:
      return 'يناير';
    case 2:
      return 'فبراير';
    case 3:
      return 'مارس';
    case 4:
      return 'أبريل';
    case 5:
      return 'مايو';
    case 6:
      return 'يونيو';
    case 7:
      return 'يوليو';
    case 8:
      return 'أغسطس';
    case 9:
      return 'سبتمبر';
    case 10:
      return 'أكتوبر';
    case 11:
      return 'نوفمبر';
    case 12:
      return 'ديسمبر';
    default:
      return 'غير معروف';
  }
}

String convertUtcTo12Hour(String utcTime) {
  try {
    String timeString = utcTime.split(" (UTC)")[0];

    DateTime utcDateTime = i.DateFormat("HH:mm").parseUtc(timeString);

    DateTime localDateTime = utcDateTime.toLocal();

    String finalTime = i.DateFormat("h:mm a").format(localDateTime);

    return finalTime.replaceAll('AM', 'ص').replaceAll('PM', 'م');
  } catch (e) {
    return utcTime;
  }
}

String converDateTime(DateTime time) {
  String finaltime = i.DateFormat('h:mm a').format(time);
  return finaltime;
}
String converDateTimetoArabic(DateTime time) {
String finalTime = i.DateFormat("h:mm a").format(time);

  return finalTime.replaceAll('AM', ' ص').replaceAll('PM', ' م');
}

String convertUtccTo12Hour(String utcTime) {
  try {
    String timeString = utcTime.split(" (UTC)")[0];
    DateTime utcDateTime = i.DateFormat("HH:mm").parseUtc(timeString);
    DateTime localDateTime = utcDateTime.toLocal();
    return i.DateFormat("h:mm").format(localDateTime);
  } catch (e) {
    return utcTime;
  }
}

String getCurrentTime12h() {
  final now = DateTime.now();
  final formatter = i.DateFormat('h:mm '); // 'h' for 12-hour, 'a' for AM/PM
  return formatter.format(now);
}

String getPrayerName(String name) {
  switch (name) {
    case 'Fajr':
      return StringsManager.fajr;
    case 'Sunrise':
      return StringsManager.sunrise;
    case 'Dhuhr':
      return StringsManager.duhur;
    case 'Asr':
      return StringsManager.asr;
    case 'Maghrib':
      return StringsManager.maghrib;
    case 'Isha':
      return StringsManager.isha;
    case 'Midnight':
      return StringsManager.midNight;
    case 'Firstthird':
      return StringsManager.firstThird;
    case 'Lastthird':
      return StringsManager.lastThird;
    default:
      return StringsManager.unKnown;
  }
}

List<CNextPryerTime> getTodayPrayerList(NewPrayerTimesEntity nextTime) {
  int today = (DateTime.now().day - 1);
  final time = nextTime.data?[today].timings;

  return <CNextPryerTime>[
    CNextPryerTime(
      prayName: StringsManager.fajr,
      prayTime: getTime(time?.fajr ?? ''),
    ),
    CNextPryerTime(
      prayName: StringsManager.sunrise,
      prayTime: getTime(time?.sunrise ?? ''),
    ),
    CNextPryerTime(
      prayName: StringsManager.duhur,
      prayTime: getTime(time?.dhuhr ?? ''),
    ),
    CNextPryerTime(
      prayName: StringsManager.asr,
      prayTime: getTime(time?.asr ?? ''),
    ),
    CNextPryerTime(
      prayName: StringsManager.maghrib,
      prayTime: getTime(time?.maghrib ?? ''),
    ),
    CNextPryerTime(
      prayName: StringsManager.isha,
      prayTime: getTime(time?.isha ?? ''),
    ),
  ];
}

List<CNextPryerTime> getTomorowPrayerList(NewPrayerTimesEntity nextTime) {
  int tomorow = (DateTime.now().day);
  final time = nextTime.data?[tomorow].timings;
  return <CNextPryerTime>[
    CNextPryerTime(
      prayName: StringsManager.fajr,
      prayTime: getTime(time?.fajr ?? '', false),
    ),
  ];
}

DateTime getTime(String time, [bool t = true]) {
  DateTime now = DateTime.now();
  DateTime parsedNextTPrayTimeUTC = i.DateFormat('HH:mm').parseUtc(time);
  DateTime finalTime =
      DateTime.utc(
        now.year,
        now.month,
        t ? now.day : now.day + 1,
        parsedNextTPrayTimeUTC.hour,
        parsedNextTPrayTimeUTC.minute,
      ).toLocal();
  return finalTime;
}

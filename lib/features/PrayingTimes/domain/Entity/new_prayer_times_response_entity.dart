import 'package:azkar_app/features/PrayingTimes/data/models/PrayingTimesModel/new_prayer_times_response.dart';

class NewPrayerTimesEntity {
  int? code;
  String? status;
  List<DataEntity>? data;

  NewPrayerTimesEntity({this.code, this.status, this.data});

  NewPrayerTimesEntity.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];
    data =
        json["data"] == null
            ? null
            : (json["data"] as List)
                .map((e) => DataEntity.fromJson(e))
                .toList();
  }

  static List<NewPrayerTimesEntity> fromList(
    List<Map<String, dynamic>> list,
  ) {
    return list.map(NewPrayerTimesEntity.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["status"] = status;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class DataEntity {
  Timings? timings;
  Date2Entity? date;

  DataEntity({this.timings, this.date});

  DataEntity.fromJson(Map<String, dynamic> json) {
    timings =
        json["timings"] == null ? null : Timings.fromJson(json["timings"]);
    date = json["date"] == null ? null : Date2Entity.fromJson(json["date"]);
  }

  static List<DataEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(DataEntity.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (timings != null) {
      _data["timings"] = timings?.toJson();
    }
    if (date != null) {
      _data["date"] = date?.toJson();
    }

    return _data;
  }
}

class Date2Entity {
  String? readable;
  String? timestamp;
  GregorianEntity? gregorian;
  HijriEntity? hijri;

  Date2Entity({this.readable, this.timestamp, this.gregorian, this.hijri});

  Date2Entity.fromJson(Map<String, dynamic> json) {
    readable = json["readable"];
    timestamp = json["timestamp"];
    gregorian =
        json["gregorian"] == null
            ? null
            : GregorianEntity.fromJson(json["gregorian"]);
    hijri = json["hijri"] == null ? null : HijriEntity.fromJson(json["hijri"]);
  }

  static List<Date2Entity> fromList(List<Map<String, dynamic>> list) {
    return list.map(Date2Entity.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["readable"] = readable;
    _data["timestamp"] = timestamp;
    if (gregorian != null) {
      _data["gregorian"] = gregorian?.toJson();
    }
    if (hijri != null) {
      _data["hijri"] = hijri?.toJson();
    }
    return _data;
  }
}

class HijriEntity {
  String? date;
  String? format;
  String? day;
  Weekday1? weekday;
  Month1? month;
  String? year;
  List<dynamic>? holidays;
  List<dynamic>? adjustedHolidays;

  HijriEntity({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,

    this.holidays,
    this.adjustedHolidays,
  });

  HijriEntity.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    format = json["format"];
    day = json["day"];
    weekday =
        json["weekday"] == null ? null : Weekday1.fromJson(json["weekday"]);
    month = json["month"] == null ? null : Month1.fromJson(json["month"]);
    year = json["year"];

    holidays = json["holidays"] ?? [];
    adjustedHolidays = json["adjustedHolidays"] ?? [];
  }

  static List<HijriEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(HijriEntity.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["format"] = format;
    _data["day"] = day;
    if (weekday != null) {
      _data["weekday"] = weekday?.toJson();
    }
    if (month != null) {
      _data["month"] = month?.toJson();
    }
    _data["year"] = year;

    if (holidays != null) {
      _data["holidays"] = holidays;
    }
    if (adjustedHolidays != null) {
      _data["adjustedHolidays"] = adjustedHolidays;
    }

    return _data;
  }
}

class GregorianEntity {
  String? date;
  String? format;
  String? day;
  Weekday? weekday;
  Month? month;
  String? year;

  GregorianEntity({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
  });

  GregorianEntity.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    format = json["format"];
    day = json["day"];
    weekday =
        json["weekday"] == null ? null : Weekday.fromJson(json["weekday"]);
    month = json["month"] == null ? null : Month.fromJson(json["month"]);
    year = json["year"];
  }

  static List<GregorianEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(GregorianEntity.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["format"] = format;
    _data["day"] = day;
    if (weekday != null) {
      _data["weekday"] = weekday?.toJson();
    }
    if (month != null) {
      _data["month"] = month?.toJson();
    }

    return _data;
  }
}

// ignore_for_file: unnecessary_question_mark

import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';

class NewPrayerTimesResponse {
  int? code;
  String? status;
  List<Data>? data;

  NewPrayerTimesResponse({this.code, this.status, this.data});
  NewPrayerTimesEntity toEntity() {
    return NewPrayerTimesEntity(
      code: code,
      status: status,
      data: data?.map((data)=>data.toEntity()).toList(),
    );
  }

  NewPrayerTimesResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];
    data =
        json["data"] == null
            ? null
            : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  static List<NewPrayerTimesResponse> fromList(
    List<Map<String, dynamic>> list,
  ) {
    return list.map(NewPrayerTimesResponse.fromJson).toList();
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

class Data {
  Timings? timings;
  Date2? date;
  Meta? meta;

  DataEntity toEntity() {
    return DataEntity(date: date?.toEntity(), timings: timings);
  }
  Data({this.timings, this.date, this.meta});


  Data.fromJson(Map<String, dynamic> json) {
    timings =
        json["timings"] == null ? null : Timings.fromJson(json["timings"]);
    date = json["date"] == null ? null : Date2.fromJson(json["date"]);
    meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (timings != null) {
      _data["timings"] = timings?.toJson();
    }
    if (date != null) {
      _data["date"] = date?.toJson();
    }
    if (meta != null) {
      _data["meta"] = meta?.toJson();
    }
    return _data;
  }
}

class Meta {
  num? latitude;
  num? longitude;
  String? timezone;
  Method? method;
  String? latitudeAdjustmentMethod;
  String? midnightMode;
  String? school;
  Offset? offset;

  Meta({
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    timezone = json["timezone"];
    method = json["method"] == null ? null : Method.fromJson(json["method"]);
    latitudeAdjustmentMethod = json["latitudeAdjustmentMethod"];
    midnightMode = json["midnightMode"];
    school = json["school"];
    offset = json["offset"] == null ? null : Offset.fromJson(json["offset"]);
  }

  static List<Meta> fromList(List<Map<String, dynamic>> list) {
    return list.map(Meta.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["timezone"] = timezone;
    if (method != null) {
      _data["method"] = method?.toJson();
    }
    _data["latitudeAdjustmentMethod"] = latitudeAdjustmentMethod;
    _data["midnightMode"] = midnightMode;
    _data["school"] = school;
    if (offset != null) {
      _data["offset"] = offset?.toJson();
    }
    return _data;
  }
}

class Offset {
  int? imsak;
  int? fajr;
  int? sunrise;
  int? dhuhr;
  int? asr;
  int? maghrib;
  int? sunset;
  int? isha;
  int? midnight;

  Offset(int i, int d, {
    this.imsak,
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.sunset,
    this.isha,
    this.midnight,
  });

  Offset.fromJson(Map<String, dynamic> json) {
    imsak = json["Imsak"];
    fajr = json["Fajr"];
    sunrise = json["Sunrise"];
    dhuhr = json["Dhuhr"];
    asr = json["Asr"];
    maghrib = json["Maghrib"];
    sunset = json["Sunset"];
    isha = json["Isha"];
    midnight = json["Midnight"];
  }

  static List<Offset> fromList(List<Map<String, dynamic>> list) {
    return list.map(Offset.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Imsak"] = imsak;
    _data["Fajr"] = fajr;
    _data["Sunrise"] = sunrise;
    _data["Dhuhr"] = dhuhr;
    _data["Asr"] = asr;
    _data["Maghrib"] = maghrib;
    _data["Sunset"] = sunset;
    _data["Isha"] = isha;
    _data["Midnight"] = midnight;
    return _data;
  }
}

class Method {
  int? id;
  String? name;
  Params? params;
  Location? location;

  Method({this.id, this.name, this.params, this.location});

  Method.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    params = json["params"] == null ? null : Params.fromJson(json["params"]);
    location =
        json["location"] == null ? null : Location.fromJson(json["location"]);
  }

  static List<Method> fromList(List<Map<String, dynamic>> list) {
    return list.map(Method.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    if (params != null) {
      _data["params"] = params?.toJson();
    }
    if (location != null) {
      _data["location"] = location?.toJson();
    }
    return _data;
  }
}

class Location {
  num? latitude;
  num? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
  }

  static List<Location> fromList(List<Map<String, dynamic>> list) {
    return list.map(Location.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    return _data;
  }
}

class Params {
  // ignore: duplicate_ignore
  // ignore: unnecessary_question_mark
  dynamic? fajr;
  dynamic? isha;

  Params({this.fajr, this.isha});

  Params.fromJson(Map<String, dynamic> json) {
    fajr = json["Fajr"];
    isha = json["Isha"];
  }

  static List<Params> fromList(List<Map<String, dynamic>> list) {
    return list.map(Params.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Fajr"] = fajr;
    _data["Isha"] = isha;
    return _data;
  }
}

class Date2 {
  String? readable;
  String? timestamp;
  Gregorian? gregorian;
  Hijri? hijri;
  Date2Entity toEntity() {
    return Date2Entity(
      gregorian: gregorian?.toEntity(),
      hijri: hijri?.toEntity(),
      readable: readable,
      timestamp: timestamp,
    );
  }

  Date2({this.readable, this.timestamp, this.gregorian, this.hijri});

  Date2.fromJson(Map<String, dynamic> json) {
    readable = json["readable"];
    timestamp = json["timestamp"];
    gregorian =
        json["gregorian"] == null
            ? null
            : Gregorian.fromJson(json["gregorian"]);
    hijri = json["hijri"] == null ? null : Hijri.fromJson(json["hijri"]);
  }

  static List<Date2> fromList(List<Map<String, dynamic>> list) {
    return list.map(Date2.fromJson).toList();
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

class Hijri {
  String? date;
  String? format;
  String? day;
  Weekday1? weekday;
  Month1? month;
  String? year;
  Designation1? designation;
  List<dynamic>? holidays;
  List<dynamic>? adjustedHolidays;
  String? method;

  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
    this.adjustedHolidays,
    this.method,
  });
  HijriEntity toEntity() {
    return HijriEntity(
      adjustedHolidays: adjustedHolidays,
      date: date,
      day: day,
      format:  format,
      holidays: holidays,
      month: month,
      weekday: weekday,
      year: year
    );
  }

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    format = json["format"];
    day = json["day"];
    weekday =
        json["weekday"] == null ? null : Weekday1.fromJson(json["weekday"]);
    month = json["month"] == null ? null : Month1.fromJson(json["month"]);
    year = json["year"];
    designation =
        json["designation"] == null
            ? null
            : Designation1.fromJson(json["designation"]);
    holidays = json["holidays"] ?? [];
    adjustedHolidays = json["adjustedHolidays"] ?? [];
    method = json["method"];
  }

  static List<Hijri> fromList(List<Map<String, dynamic>> list) {
    return list.map(Hijri.fromJson).toList();
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
    if (designation != null) {
      _data["designation"] = designation?.toJson();
    }
    if (holidays != null) {
      _data["holidays"] = holidays;
    }
    if (adjustedHolidays != null) {
      _data["adjustedHolidays"] = adjustedHolidays;
    }
    _data["method"] = method;
    return _data;
  }
}

class Designation1 {
  String? abbreviated;
  String? expanded;

  Designation1({this.abbreviated, this.expanded});

  Designation1.fromJson(Map<String, dynamic> json) {
    abbreviated = json["abbreviated"];
    expanded = json["expanded"];
  }

  static List<Designation1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Designation1.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["abbreviated"] = abbreviated;
    _data["expanded"] = expanded;
    return _data;
  }
}

class Month1 {
  int? number;
  String? en;
  String? ar;
  int? days;

  Month1({this.number, this.en, this.ar, this.days});

  Month1.fromJson(Map<String, dynamic> json) {
    number = json["number"];
    en = json["en"];
    ar = json["ar"];
    days = json["days"];
  }

  static List<Month1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Month1.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["number"] = number;
    _data["en"] = en;
    _data["ar"] = ar;
    _data["days"] = days;
    return _data;
  }
}

class Weekday1 {
  String? en;
  String? ar;

  Weekday1({this.en, this.ar});

  Weekday1.fromJson(Map<String, dynamic> json) {
    en = json["en"];
    ar = json["ar"];
  }

  static List<Weekday1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Weekday1.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["en"] = en;
    _data["ar"] = ar;
    return _data;
  }
}

class Gregorian {
  String? date;
  String? format;
  String? day;
  Weekday? weekday;
  Month? month;
  String? year;
  Designation? designation;
  bool? lunarSighting;

  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.lunarSighting,
  });
  GregorianEntity toEntity() {
    return GregorianEntity(
      date: date,
      day: day,
      format: format,
      year: year,
      month: month,
      weekday: weekday,
    );
  }

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    format = json["format"];
    day = json["day"];
    weekday =
        json["weekday"] == null ? null : Weekday.fromJson(json["weekday"]);
    month = json["month"] == null ? null : Month.fromJson(json["month"]);
    year = json["year"];
    designation =
        json["designation"] == null
            ? null
            : Designation.fromJson(json["designation"]);
    lunarSighting = json["lunarSighting"];
  }

  static List<Gregorian> fromList(List<Map<String, dynamic>> list) {
    return list.map(Gregorian.fromJson).toList();
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
    if (designation != null) {
      _data["designation"] = designation?.toJson();
    }
    _data["lunarSighting"] = lunarSighting;
    return _data;
  }
}

class Designation {
  String? abbreviated;
  String? expanded;

  Designation({this.abbreviated, this.expanded});

  Designation.fromJson(Map<String, dynamic> json) {
    abbreviated = json["abbreviated"];
    expanded = json["expanded"];
  }

  static List<Designation> fromList(List<Map<String, dynamic>> list) {
    return list.map(Designation.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["abbreviated"] = abbreviated;
    _data["expanded"] = expanded;
    return _data;
  }
}

class Month {
  int? number;
  String? en;

  Month({this.number, this.en});

  Month.fromJson(Map<String, dynamic> json) {
    number = json["number"];
    en = json["en"];
  }

  static List<Month> fromList(List<Map<String, dynamic>> list) {
    return list.map(Month.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["number"] = number;
    _data["en"] = en;
    return _data;
  }
}

class Weekday {
  String? en;

  Weekday({this.en});

  Weekday.fromJson(Map<String, dynamic> json) {
    en = json["en"];
  }

  static List<Weekday> fromList(List<Map<String, dynamic>> list) {
    return list.map(Weekday.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["en"] = en;
    return _data;
  }
}

class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;

  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json["Fajr"];
    sunrise = json["Sunrise"];
    dhuhr = json["Dhuhr"];
    asr = json["Asr"];
    sunset = json["Sunset"];
    maghrib = json["Maghrib"];
    isha = json["Isha"];
    imsak = json["Imsak"];
    midnight = json["Midnight"];
    firstthird = json["Firstthird"];
    lastthird = json["Lastthird"];
  }

  static List<Timings> fromList(List<Map<String, dynamic>> list) {
    return list.map(Timings.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["Fajr"] = fajr;
    _data["Sunrise"] = sunrise;
    _data["Dhuhr"] = dhuhr;
    _data["Asr"] = asr;
    _data["Sunset"] = sunset;
    _data["Maghrib"] = maghrib;
    _data["Isha"] = isha;
    _data["Imsak"] = imsak;
    _data["Midnight"] = midnight;
    _data["Firstthird"] = firstthird;
    _data["Lastthird"] = lastthird;
    return _data;
  }
}

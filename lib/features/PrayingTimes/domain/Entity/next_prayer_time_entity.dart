import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';

class NextPrayerTimeEntity {
  int? code;
  String? status;
  DataEntity? data;

  NextPrayerTimeEntity({this.code, this.status, this.data});

  NextPrayerTimeEntity.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];
    data = json["data"] == null ? null : (json["data"]);
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["status"] = status;
    if (data != null) {
      _data["data"] = data;
    }
    return _data;
  }
}


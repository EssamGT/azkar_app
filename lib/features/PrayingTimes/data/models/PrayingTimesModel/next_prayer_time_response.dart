
import 'package:azkar_app/features/PrayingTimes/data/models/PrayingTimesModel/new_prayer_times_response.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/next_prayer_time_entity.dart';

class NextPrayerTimeResponse {
  int? code;
  String? status;
  Data? data;

  NextPrayerTimeResponse({this.code, this.status, this.data});
  NextPrayerTimeEntity toEntity() {
    return NextPrayerTimeEntity(
      code: code,
      status: status,
      data: data?.toEntity(),
    );
  }

  NextPrayerTimeResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
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


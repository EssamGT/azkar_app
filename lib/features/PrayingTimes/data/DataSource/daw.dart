import 'package:azkar_app/features/PrayingTimes/data/models/PrayingTimesModel/new_prayer_times_response.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/PrayingTimesModel/next_prayer_time_response.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

abstract class Daw {
  Future<Either<NewPrayerTimesResponse,String>> getPrayingTimes(Position location);
  Future<Either<NextPrayerTimeResponse,String>> getNextPrayingTimes(Position location);

}

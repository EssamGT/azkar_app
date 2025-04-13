import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/next_prayer_time_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

abstract class PrayingTimesRepo {
 Future<Either<NewPrayerTimesEntity,String>>  getPrayingTimes(Position location);
 Future<Either<NextPrayerTimeEntity,String>>  getNextPrayingTimes(Position location);
}

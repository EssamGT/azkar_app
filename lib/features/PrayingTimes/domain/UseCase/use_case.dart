import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/next_prayer_time_entity.dart';
import 'package:azkar_app/features/PrayingTimes/domain/repository/praying_times_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class UseCase {
  PrayingTimesRepo repo;
  @factoryMethod
  UseCase(this.repo);
  Future<Either<NewPrayerTimesEntity,String>> call(Position location) => repo.getPrayingTimes(location);
  Future<Either<NextPrayerTimeEntity,String>> callNextTime(Position location) => repo.getNextPrayingTimes(location);
}

import 'package:azkar_app/core/remote/Internet_checker.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/features/PrayingTimes/data/DataSource/daw.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/next_prayer_time_entity.dart';
import 'package:azkar_app/features/PrayingTimes/domain/repository/praying_times_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PrayingTimesRepo)
class PrayingTimesRepoImpl extends PrayingTimesRepo {
  Daw daw;
  @factoryMethod
  PrayingTimesRepoImpl(this.daw);
  @override
  Future<Either<NewPrayerTimesEntity, String>> getPrayingTimes(
    Position location,
  ) async {
    bool internet = await InternetChecker.internetConnection();
    if (internet) {
      var result = await daw.getPrayingTimes(location);
      return result.fold(
        (response) {
          return Left(response.toEntity());
        },
        (error) {
          return Right(error);
        },
      );
    } else {
      return Right(StringsManager.noInternetConction);
    }
  }

  @override
  Future<Either<NextPrayerTimeEntity, String>> getNextPrayingTimes(Position location) async{
    bool internet = await InternetChecker.internetConnection();
    if (internet) {
      var result = await daw.getNextPrayingTimes(location);
      return result.fold(
        (response) {
          return Left(response.toEntity());
        },
        (error) {
          return Right(error);
        },
      );
    } else {
      return Right(StringsManager.noInternetConction);
    }
  }
}

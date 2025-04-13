import 'package:azkar_app/core/LocationServices/location.dart';
import 'package:azkar_app/core/remote/api_manager.dart';
import 'package:azkar_app/core/remote/ednpoints.dart';
import 'package:azkar_app/features/PrayingTimes/data/DataSource/daw.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/PrayingTimesModel/new_prayer_times_response.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/PrayingTimesModel/next_prayer_time_response.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: Daw)
class DawImpl extends Daw {
  ApiManager apiManager;
  @factoryMethod
  DawImpl(this.apiManager);

  @override
  Future<Either<NewPrayerTimesResponse, String>> getPrayingTimes(
    Position location,
  ) async {
    try {
      int method =4;
      String countery = await getCountryFromLocation();
      if (countery.toLowerCase() == 'egypt') {
        method = 5;
      }
      var json = await apiManager.getRequest(Endpoints.prayingTimes, {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'method': method,
        'timezonestring': 'UTC',
      });
      NewPrayerTimesResponse times = NewPrayerTimesResponse.fromJson(json.data);
      if (times.code == 200) {
        return Left(times);
      } else {
        return Right(times.data.toString());
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  @override
  Future<Either<NextPrayerTimeResponse, String>> getNextPrayingTimes(Position location) async{
     try {
      int method =4;
      String countery = await getCountryFromLocation();
      if (countery.toLowerCase() == 'egypt') {
        method = 5;
      }
      var json = await apiManager.getRequest(Endpoints.nextPrayTime, {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'method': method,
        'timezonestring': 'UTC',
      });
      NextPrayerTimeResponse times = NextPrayerTimeResponse.fromJson(json.data);
      if (times.code == 200) {
        return Left(times);
      } else {
        return Right(times.data.toString());
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
}

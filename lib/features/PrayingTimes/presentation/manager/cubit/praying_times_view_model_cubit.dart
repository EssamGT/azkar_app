import 'dart:async';
import 'package:azkar_app/core/LocationServices/location.dart';
import 'package:azkar_app/core/NotiServices/Notification_Services.dart';
import 'package:azkar_app/core/cache/prefs_helper.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/c_rem_Time.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/custom_praye_time_model.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:azkar_app/features/PrayingTimes/domain/UseCase/use_case.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/home_widget/home_widget_config.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/prayr_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;
part 'praying_times_view_model_state.dart';

@injectable
class PrayingTimesViewModelCubit extends Cubit<PrayingTimesViewModelState> {
  final UseCase useCase;
  Timer? _timer;

  @factoryMethod
  PrayingTimesViewModelCubit(this.useCase)
    : super(PrayingTimesViewModelInitial());
  late Position position;
  late String address;
  CNextPryerTime? nextPryerTime;
  bool isNotInit = true;
  late NewPrayerTimesEntity entityRes;

  static PrayingTimesViewModelCubit get(BuildContext context) =>
      BlocProvider.of(context);

  /// Fetches fresh location and gets prayer times every time this function is called
  Future<void> getPrayingTimes() async {
    emit(Loading());
    try {
      position = await getLocation(); // Always fetch fresh location
      address = await getAddressInArabic(position.latitude, position.longitude);
      // PrefsHelper.setLocation(position.latitude, position.longitude);
      PrefsHelper.setAddress(address);
      var response = await useCase.call(position);
      response.fold(
        (entity) {
          entityRes = entity;
          PrefsHelper.setPrayerTime(entity);
          return emit(Sucsses(entity));
        },
        (error) {
          if (error == StringsManager.noInternetConction) {
            // ignore: unnecessary_null_comparison
            if (entityRes == null) {
              emit(Error(StringsManager.noInternetConction));
            }
            cahedPrayer();
          } else {
            emit(Error(error));
          }
        },
      );
    } catch (e) {
      emit(Error(StringsManager.noInternetConction));
    }
  }

  Future<void> cahedPrayer() async {
    emit(Loading());
    NewPrayerTimesEntity? cahedEntity = await PrefsHelper.getPrayerTime();
    String? cachedAddress = await PrefsHelper.getAddress();

    if (cahedEntity == null || cachedAddress == null) {
      await getPrayingTimes();
    } else {
      entityRes = cahedEntity;
      address = cachedAddress;
      emit(Sucsses(cahedEntity));
    }
  }

  Future<CNextPryerTime> getNextPray() async {
    try {
      List<CNextPryerTime> todayList = getTodayPrayerList(entityRes);
      DateTime now = DateTime.now();

      for (CNextPryerTime nextPray in todayList) {
        if (nextPray.prayTime.isAfter(now)) {
          final tzDateTime = tz.TZDateTime.from(nextPray.prayTime, tz.local);
          String title = "${StringsManager.prayTime} ${nextPray.prayName}";

          String body = '';

          await NotificationServices().scheduleNotification(
            id: 99,
            title: title,
            body: body,
            scheduledDate: tzDateTime,
          );

          return nextPray;
        }
      }

      List<CNextPryerTime> tomorrowList = getTomorowPrayerList(entityRes);

      if (tomorrowList.isNotEmpty) {
        final tzDateTime = tz.TZDateTime.from(
          tomorrowList.first.prayTime,
          tz.local,
        );
        String title =
            "${StringsManager.prayTime} ${tomorrowList.first.prayName}"; // Arabic title
        String body = '';

        await NotificationServices().scheduleNotification(
          id: 99,
          title: title,
          body: body,
          scheduledDate: tzDateTime,
        );

        return tomorrowList.first;
      }

      return CNextPryerTime(prayName: 'Unknown', prayTime: DateTime.now());
    } catch (e) {
      return CNextPryerTime(prayName: 'Error', prayTime: DateTime.now());
    }
  }

  Future<void> getPrayerTimer() async {
    try {
      emit(NextPrayerLoading());

      nextPryerTime ??= await getNextPray();

      DateTime now = DateTime.now();
      final remaining = nextPryerTime!.prayTime.difference(now);

      if (nextPryerTime!.prayTime.isAfter(now)) {
        final remianTime = CRemTime(
          prayName: nextPryerTime?.prayName ?? '',
          prayTime: converDateTimetoArabic(nextPryerTime!.prayTime),
          remH: remaining.inHours.toString(),
          remMIn: ((remaining.inSeconds / 60).ceil() % 60).toString(),
          hijriDay: entityRes.data?[now.day - 1].date?.hijri?.day ?? '',
          hijriMonth: entityRes.data?[now.day - 1].date?.hijri?.month?.ar ?? '',
          hijriYear: entityRes.data?[now.day - 1].date?.hijri?.year ?? '',
        );
        
        emit(NextPrayerSucsses(remianTime));
      } else {
        nextPryerTime = null;

        emit(
          NextPrayerError(
            "Prayer time has passed. Fetching next prayer time...",
          ),
        );

        await getPrayerTimer();
      }
    } catch (e) {
      emit(NextPrayerError(e.toString()));
    }
  }

  void startPrayerTimer() {
    _timer?.cancel();

    Future.delayed(Duration(milliseconds: 100), () {
      getPrayerTimer();
      _timer = Timer.periodic(Duration(seconds: 15), (_) => getPrayerTimer());
    });
  }

  void stopPrayerTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cleanup timer when Cubit is closed
    return super.close();
  }

  void triggerWidgetUpdate(context, Widget widget) async {
    await HomeWidgetConfig.update(context, widget);
    emit(HomeWidget()); // Emit a new state to notify listeners if needed.
  }





}

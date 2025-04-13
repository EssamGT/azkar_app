part of 'praying_times_view_model_cubit.dart';

@immutable
sealed class PrayingTimesViewModelState {}

final class PrayingTimesViewModelInitial extends PrayingTimesViewModelState {}

class Loading extends PrayingTimesViewModelState {}
class HomeWidget extends PrayingTimesViewModelState {}

// ignore: must_be_immutable
class Sucsses extends PrayingTimesViewModelState {
  NewPrayerTimesEntity entity;
  Sucsses(this.entity);
}

// ignore: must_be_immutable
class Error extends PrayingTimesViewModelState {
  String error;
  Error(this.error);
}

class NextPrayerLoading extends PrayingTimesViewModelState {}

// ignore: must_be_immutable
class NextPrayerSucsses extends PrayingTimesViewModelState {
  CRemTime remTime;
  NextPrayerSucsses(this.remTime);
}

// ignore: must_be_immutable
class NextPrayerError extends PrayingTimesViewModelState {
  String error;
  NextPrayerError(this.error);
}

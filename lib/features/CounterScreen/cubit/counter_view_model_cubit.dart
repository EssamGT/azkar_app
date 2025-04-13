import 'package:azkar_app/core/cache/prefs_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_view_model_state.dart';

class CounterViewModelCubit extends Cubit<CounterViewModelState> {
  CounterViewModelCubit() : super(CounterViewModelInitial());
  static CounterViewModelCubit get(BuildContext context) =>
      BlocProvider.of(context);
  int counter = 0;
  bool tap = false;
  bool vibrate = PrefsHelper.getVibrationSettings();
  int vibrateLimt = PrefsHelper.getVibrationSettingsLimit();

  ini() {
    emit(Add());
  }

  add() {
    counter++;
    tap = true;
    emit(Add());
  }

  clear() {
    counter = 0;
    emit(Add());
  }

  void enableDisableVibration() {

    vibrate = !vibrate;
    PrefsHelper.setVibrationSettings(vibrate);
    emit(Add());
  }

  bool vibrationLimit() {
    
    PrefsHelper.setVibrationSettingsLimit(vibrateLimt);
    if (counter == vibrateLimt) {
      return true;
    } else {
      return false;
    }
  }
}

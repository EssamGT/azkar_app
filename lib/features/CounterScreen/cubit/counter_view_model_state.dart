part of 'counter_view_model_cubit.dart';

@immutable
sealed class CounterViewModelState {}

final class CounterViewModelInitial extends CounterViewModelState {

}

final class Add extends CounterViewModelState {
  
}
final class Clear extends CounterViewModelState {
}

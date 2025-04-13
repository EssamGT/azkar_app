part of 'azkar_details_view_model_cubit.dart';

@immutable
sealed class AzkarDetailsViewModelState {}

final class AzkarDetailsViewModelInitial extends AzkarDetailsViewModelState {}

class Loading extends AzkarDetailsViewModelState {}

// ignore: must_be_immutable
class Succsess extends AzkarDetailsViewModelState {
  List<Zekr> azkarList;
  Succsess(this.azkarList);
}

// ignore: must_be_immutable
class Error extends AzkarDetailsViewModelState {
  String error;
  Error(this.error);
}

// ignore: must_be_immutable
class Finsish extends AzkarDetailsViewModelState {
  String massage;
  Finsish(this.massage);
}


// ignore: must_be_immutable
class ItemRemoved extends AzkarDetailsViewModelState {
  
  List<Zekr> azkarList;
  ItemRemoved( this.azkarList);
}

import 'dart:math';

import 'package:azkar_app/core/boxes/azkar_gen.dart';
import 'package:azkar_app/core/cache/prefs_helper.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/ZekerItemWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'azkar_details_view_model_state.dart';



class AzkarDetailsViewModelCubit extends Cubit<AzkarDetailsViewModelState> {
  AzkarDetailsViewModelCubit() : super(AzkarDetailsViewModelInitial());
  static AzkarDetailsViewModelCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final listKey = GlobalKey<AnimatedListState>();

  final Box<Zekr> box = Hive.box<Zekr>('azkarBox');
  List<Zekr> finalList = [];


  onTap(int index, azkarType) {
    if (finalList[index].count >= 2) {
      finalList[index].count--;
      emit(Succsess(finalList));
    } else if (finalList[index].count <= 1) {
      Zekr selected = finalList[index];
      finalList.removeAt(index);
      listKey.currentState!.removeItem(
        index,
        (context, animation) => ZekerItemWidget(
          zeker: selected,
          type: azkarType,
          animation: animation,
          onClick: () {},
        ),
        duration: Duration(milliseconds: 300),
      );
    }

    emit(Succsess(List.from(finalList)));
    if (finalList.isEmpty) {
      var randomIndex = Random().nextInt(islamicGreetings.length);

      emit(Finsish(islamicGreetings[randomIndex]));
    }
  }


  getAzkarList(AzkarType type) {
    emit(Loading());
    try {
      List<Zekr> azkarFilterd =
          box.values.where((zekr) => zekr.type == type).toList();
      finalList =
          azkarFilterd
              .map(
                (zekr) => Zekr(
                  text: zekr.text,
                  count: zekr.count,
                  type: zekr.type,
                  added: zekr.added,
                ),
              )
              .toList();
      emit(Succsess(List.from(finalList)));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> deleteZekr(Zekr zekr, index) async {
    if (zekr.added) {
      for (int i = 0; i < box.length; i++) {
        Zekr? zekra = box.getAt(i);
        if (zekra?.text == zekr.text && zekra?.type == zekr.type) {
          box.deleteAt(i);
        }
      }
      Zekr selected = finalList[index];
      finalList.removeAt(index);
      listKey.currentState!.removeItem(
        index,
        (context, animation) => ZekerItemWidget(
          zeker: selected,
          type: zekr.type,
          animation: animation,
          onClick: () {},
        ),
        duration: Duration(milliseconds: 300),
      );
      emit(Succsess(List.from(finalList)));
    }
  }

  addZekr(String text, int count, AzkarType type) {
    Zekr zekr = Zekr(text: text, count: count, type: type, added: true);
    box.add(zekr);
    listKey.currentState!.insertItem(
      finalList.length,

      duration: Duration(milliseconds: 300),
    );
    finalList.add(zekr);
    emit(Succsess(List.from(finalList)));
  }

  editZekr(Zekr zekr, String newText, int newCount) {
    if (zekr.added) {
      for (int i = 0; i < box.length; i++) {
        Zekr? zekra = box.getAt(i);
        if (zekra?.text == zekr.text && zekra?.type == zekr.type) {
          box.putAt(
            i,
            Zekr(text: newText, count: newCount, type: zekr.type, added: true),
          );
        }
      }
      getAzkarList(zekr.type);
    }
  }

  fontSizePlus() {
    double fontsize = PrefsHelper.getFontSize();
    if (fontsize < 30) {
      PrefsHelper.setFontSize(fontsize + 2);
      emit(Succsess(List.from(finalList)));
    }
  }

  fontSizeMin() {
    double fontsize = PrefsHelper.getFontSize();
    if (fontsize > 15) {
      PrefsHelper.setFontSize(fontsize - 2);
      emit(Succsess(List.from(finalList)));
    }
  }
}

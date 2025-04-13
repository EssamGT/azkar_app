import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarScreen/widget/menu.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:flutter/material.dart';

Widget getAppTitle(AzkarType azkarType, BuildContext context) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSize.s24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: azkarColorFromType(azkarType),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSize.s32),
            bottomRight: Radius.circular(AppSize.s32),
          ),
        ),
        child: Column(
          children: [
            azkarIconFromType(azkarType),
            const SizedBox(height: AppSize.s12),
            Text(
              azkarNameFromType(azkarType),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color:
                    azkarType == AzkarType.night ||
                            azkarType == AzkarType.sleep ||
                            azkarType == AzkarType.praying ||
                            azkarType == AzkarType.saving ||
                            azkarType == AzkarType.mosque ||
                            azkarType == AzkarType.mostazed ||
                            azkarType == AzkarType.ahadeth
                        ? ColorManager.white
                        : ColorManager.black,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 1,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            color:
                azkarType == AzkarType.night ||
                        azkarType == AzkarType.sleep ||
                        azkarType == AzkarType.praying ||
                        azkarType == AzkarType.saving ||
                        azkarType == AzkarType.mosque ||
                        azkarType == AzkarType.mostazed ||
                        azkarType == AzkarType.ahadeth
                    ? ColorManager.white
                    : ColorManager.black,
          ),
        ),
      ),
      Positioned(right: 1, child: men(azkarType)),
    ],
  );
}

String azkarNameFromType(AzkarType type) {
  switch (type) {
    case AzkarType.morning:
      return StringsManager.azkarDay;
    case AzkarType.night:
      return StringsManager.azkarNight;
    case AzkarType.praying:
      return StringsManager.prayingAzkar;
    case AzkarType.saving:
      return StringsManager.azkarSaving;
    case AzkarType.sleep:
      return StringsManager.azkarSleep;
    case AzkarType.wakeUp:
      return StringsManager.azkarWakeUp;
    case AzkarType.mosque:
      return StringsManager.azkarMosque;
    case AzkarType.mostazed:
      return StringsManager.azkrMostazed;
    case AzkarType.ahadeth:
      return StringsManager.azkarNabawi;
  }
}

Icon azkarIconFromType(AzkarType type) {
  switch (type) {
    case AzkarType.morning:
      return Icon(
        Icons.wb_sunny,
        size: AppSize.s48,
        // color: Colors.teal.shade700
      );
    case AzkarType.night:
      return Icon(
        Icons.nightlight_round,
        size: AppSize.s48,
        color: ColorManager.white,
      );
    case AzkarType.praying:
      return Icon(Icons.mosque, size: AppSize.s48, color: ColorManager.white);
    case AzkarType.saving:
      return Icon(Icons.shield, size: AppSize.s48, color: ColorManager.white);
    case AzkarType.sleep:
      return Icon(
        Icons.bedtime,
        size: AppSize.s48,
        color: ColorManager.white,
        // color: Colors.teal.shade700
      );
    case AzkarType.wakeUp:
      return Icon(
        Icons.alarm,
        size: AppSize.s48,
        // color: Colors.teal.shade700
      );
    case AzkarType.mosque:
      return Icon(
        Icons.mosque_outlined,
        size: AppSize.s48,
        color: ColorManager.white,
        // color: Colors.teal.shade700
      );
    case AzkarType.mostazed:
      return Icon(
        Icons.plus_one,
        size: AppSize.s48,
        color: ColorManager.white,
        // color: Colors.teal.shade700
      );
    case AzkarType.ahadeth:
      return Icon(
        Icons.mark_chat_unread,
        size: AppSize.s48,
        color: ColorManager.white,
        // color: Colors.teal.shade700
      );
  }
}

List<Color> azkarColorFromType(AzkarType type) {
  switch (type) {
    case AzkarType.morning:
      return ColorManager.daySunColors;
    case AzkarType.night:
      return ColorManager.dayNightColors;
    case AzkarType.praying:
      return ColorManager.prayingColors;
    case AzkarType.saving:
      return ColorManager.savingColors;
    case AzkarType.sleep:
      return ColorManager.sleepColors;
    case AzkarType.wakeUp:
      return ColorManager.wakeUpColors;
    case AzkarType.mosque:
      return ColorManager.mosqueColors;
    case AzkarType.mostazed:
      return ColorManager.mosatzed;
    case AzkarType.ahadeth:
      return ColorManager.nabawiya;
  }
}

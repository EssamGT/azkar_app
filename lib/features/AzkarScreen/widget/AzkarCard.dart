import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/features/AzkarScreen/widget/card.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:flutter/material.dart';

Widget azkarCard({required AzkarType azkarType}) {
  switch (azkarType) {
    case AzkarType.morning:
      return AzkarCardWidget(
        title: StringsManager.azkarDay,
        subtitle: StringsManager.azkarDaySub,
        icon: Icons.wb_sunny,
        backgroundGradient: LinearGradient(colors: ColorManager.daySunColors),
        type: azkarType,
      );
    case AzkarType.night:
      return AzkarCardWidget(
        title: StringsManager.azkarNight,
        subtitle: StringsManager.azkarNightSub,
        icon: Icons.nightlight_round,
        backgroundGradient: LinearGradient(colors: ColorManager.dayNightColors),
        type: azkarType,
      );
    case AzkarType.praying:
      return AzkarCardWidget(
        type: azkarType,
        title: StringsManager.prayingAzkar,
        subtitle: StringsManager.prayingAzkarSub,
        icon: Icons.mosque,
        backgroundGradient: LinearGradient(colors: ColorManager.prayingColors),
      );
    case AzkarType.saving:
      return AzkarCardWidget(
        type: azkarType,
        title: StringsManager.azkarSaving,
        subtitle: StringsManager.azkarSavingSub,
        icon: Icons.shield,
        backgroundGradient: LinearGradient(colors: ColorManager.savingColors),
      );

    case AzkarType.sleep:
      return AzkarCardWidget(
        type: azkarType,
        title: StringsManager.azkarSleep,
        subtitle: StringsManager.azkarSleepSub,
        icon: Icons.bedtime,
        backgroundGradient: LinearGradient(colors: ColorManager.sleepColors),
      );

    case AzkarType.wakeUp:
      return AzkarCardWidget(
        type: azkarType,
        title: StringsManager.azkarWakeUp,
        subtitle: StringsManager.azkarWakeUpSub,
        icon: Icons.alarm,
        backgroundGradient: LinearGradient(colors: ColorManager.wakeUpColors),
      );
    case AzkarType.mosque:
      return AzkarCardWidget(
        type: azkarType,
        title: StringsManager.azkarMosque,
        subtitle: StringsManager.azkarMosqueSub,
        icon: Icons.mosque_outlined,
        backgroundGradient: LinearGradient(
          colors: ColorManager.mosqueColors,
        ),
      );
    case AzkarType.mostazed:
      return AzkarCardWidget(
        type: azkarType,
        title: StringsManager.azkrMostazed,
        subtitle: StringsManager.azkrMostazedSub,
        icon: Icons.plus_one,
        backgroundGradient: LinearGradient(
          colors: ColorManager.mosatzed,
        ),
      );
    case AzkarType.ahadeth:
      return AzkarCardWidget(
        type: azkarType,
        title: StringsManager.azkarNabawi,
        subtitle: StringsManager.azkarNabawiSub,
        icon: Icons.mark_chat_unread,
        backgroundGradient: LinearGradient(
          colors: ColorManager.nabawiya,
        ),
      );
  }
}

// Widget azkarCardsec({required AzkarType azkarType}) {
//   switch (azkarType) {
//     case AzkarType.morning:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkarDay,
//         subtitle: StringsManager.azkarDaySub,
//         icon: Icons.wb_sunny,
//         backgroundGradient: LinearGradient(colors: ColorManager.daySunColors),
//       );
//     case AzkarType.night:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkarNight,
//         subtitle: StringsManager.azkarNightSub,
//         icon: Icons.nightlight_round,
//         backgroundGradient: LinearGradient(colors: ColorManager.dayNightColors),
//       );
//     case AzkarType.praying:
//       return AzkarCardWidgetsec(
//         title: StringsManager.prayingAzkar,
//         subtitle: StringsManager.prayingAzkarSub,
//         icon: Icons.mosque,
//         backgroundGradient: LinearGradient(colors: ColorManager.prayingColors),
//       );
//     case AzkarType.saving:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkarSaving,
//         subtitle: StringsManager.azkarSavingSub,
//         icon: Icons.shield,
//         backgroundGradient: LinearGradient(colors: ColorManager.savingColors),
//       );

//     case AzkarType.sleep:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkarSleep,
//         subtitle: StringsManager.azkarSleepSub,
//         icon: Icons.bedtime,
//         backgroundGradient: LinearGradient(colors: ColorManager.sleepColors),
//       );

//     case AzkarType.wakeUp:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkarWakeUp,
//         subtitle: StringsManager.azkarWakeUpSub,
//         icon: Icons.alarm,
//         backgroundGradient: LinearGradient(colors: ColorManager.wakeUpColors),
//       );
//     case AzkarType.mosque:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkarMosque,
//         subtitle: StringsManager.azkarMosqueSub,
//         icon: Icons.mosque_outlined,
//         backgroundGradient: LinearGradient(
//           colors: ColorManager.blueGreenBackground,
//         ),
//       );
//     case AzkarType.mostazed:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkrMostazed,
//         subtitle: StringsManager.azkrMostazedSub,
//         icon: Icons.plus_one,
//         backgroundGradient: LinearGradient(
//           colors: ColorManager.blueGreenBackground,
//         ),
//       );
//     case AzkarType.ahadeth:
//       return AzkarCardWidgetsec(
//         title: StringsManager.azkarNabawi,
//         subtitle: StringsManager.azkarNabawiSub,
//         icon: Icons.mark_chat_unread,
//         backgroundGradient: LinearGradient(
//           colors: ColorManager.blueGreenBackground,
//         ),
//       );
//   }
// }

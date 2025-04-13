import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/cubit/azkar_details_view_model_cubit.dart';
import 'package:azkar_app/features/AzkarScreen/widget/add_dialog.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PopupMenuButton men(AzkarType type) {
  return PopupMenuButton(
  
    
    icon: Icon(Icons.menu),
    iconColor: getMenuColor(type),
     iconSize: AppSize.s35,
     shadowColor: ColorManager.black,
     color: ColorManager.comapsBackground,
     
     itemBuilder: (context) {
      return [
        PopupMenuItem(
        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringsManager.add),
              SizedBox(width: 1),
              Icon(CupertinoIcons.add),
            ],
          ),
          onTap: () => showZekrtDialog(context, type),
        ),
        PopupMenuItem(
        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringsManager.fontSizePlus),
              SizedBox(width: 1),
              Icon(Icons.font_download_sharp),
            ],
          ),
          onTap: () => AzkarDetailsViewModelCubit.get(context).fontSizePlus(),
        ),

        PopupMenuItem(
        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringsManager.fontSizeMin),
              SizedBox(width: 1),
              Icon(Icons.format_size_outlined),
            ],
          ),
          onTap: () => AzkarDetailsViewModelCubit.get(context).fontSizeMin(),
        ),
      ];
    },
    // child: Padding(
    //   padding: const EdgeInsets.all(AppPadding.p8),
    //   child: Icon(Icons.menu, size: AppSize.s30, color: getcolor(type)),
    // ),
  );
}

Color getMenuColor(AzkarType type) {
  switch (type) {
    case AzkarType.morning:
      return ColorManager.black;
    case AzkarType.night:
      return ColorManager.white;
    case AzkarType.praying:
      return ColorManager.white;
    case AzkarType.saving:
      return ColorManager.white;
    case AzkarType.sleep:
      return ColorManager.white;
    case AzkarType.wakeUp:
      return ColorManager.black;
    case AzkarType.mosque:
      return ColorManager.white;
    case AzkarType.mostazed:
      return ColorManager.white;
    case AzkarType.ahadeth:
      return ColorManager.white;
  }
}

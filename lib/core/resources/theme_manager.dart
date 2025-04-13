import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/style_manger.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(
    backgroundColor: ColorManager.primaryop,
    centerTitle: false,
    titleTextStyle: getMediumStyle(color: ColorManager.white,fontSize: FontSize.s18)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
       backgroundColor: ColorManager.primaryop,
       selectedItemColor: ColorManager.white,
       enableFeedback: true,
      
       

    ),
    textTheme:  TextTheme(
      //praying times
      bodyMedium: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18
      ),
      //nextpray
      titleMedium:  getBoldStyle(
        color: ColorManager.white.withOpacity(0.70),
        fontSize: FontSize.s16
      ),
      //nextpray header
      titleLarge:  getBoldStyle(
        color: ColorManager.white,
        
        fontSize: FontSize.s24
      ),
      //nextpray header colock
      titleSmall: getBoldStyle(
        color: ColorManager.white,
        
        fontSize: FontSize.s20
      ) ,
      // white 16 
      labelSmall: getBoldStyle(
        color: ColorManager.white,
      
        fontSize: FontSize.s16
      ),
      // azkar repate time 
      displaySmall: TextStyle(
        color: ColorManager.black,
        fontWeight: FontWeightManager.bold,
        fontSize: FontSize.s12
      ),
    bodyLarge: getBoldStyle(fontSize: FontSize.s18,color: ColorManager.black ),
    bodySmall: getBoldStyle(fontSize: FontSize.s20, color: ColorManager.black),
     // azkar deatails 
     labelMedium: TextStyle(
        color: ColorManager.black,
        fontWeight: FontWeightManager.regular,
        fontSize: FontSize.s18
      ),
  ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.white,
       circularTrackColor: ColorManager.transparent
    ),
    
  );
}

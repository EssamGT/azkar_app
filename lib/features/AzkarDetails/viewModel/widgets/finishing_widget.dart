import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/get_app_titile.dart';
import 'package:flutter/material.dart';

Widget finishingWidget(var state, AzkarType azkarType, BuildContext context) {
  return Scaffold(
    body: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: azkarColorFromType(azkarType),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 1),
                child: Text(
                  state.massage,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: ColorManager.white,
                    fontSize: FontSize.s20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppSize.s100),

        
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: AppSize.s60, 
            height: AppSize.s60, 
            decoration: BoxDecoration(
              color: ColorManager.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(AppSize.s14),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withOpacity(0.2),
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s14)),
              onPressed: () {
                Navigator.pop(context);
              },
              splashColor: ColorManager.primary.withOpacity(0.3),
              highlightColor: ColorManager.primary.withOpacity(0.2),
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: ColorManager.white,
                size:AppSize.s24,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/core/routes/Routes.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:flutter/material.dart';

class AzkarCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Gradient backgroundGradient;
  final IconData icon;
  final AzkarType type;
  const AzkarCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundGradient,
    required this.icon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
       
      onTap: () {
        Navigator.of(context).pushNamed(Routes.azkarDetails, arguments: type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        margin:  EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p10,
        ),
        padding:  EdgeInsets.all(AppPadding.p14),
        height: width * 0.25,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          borderRadius: BorderRadius.circular(AppSize.s24),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Modern Icon Container
            Container(
              width: AppSize.s46,
              height: AppSize.s46,
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(AppSize.s14),
              ),
              child: Icon(icon, color: ColorManager.white, size: AppSize.s26),
            ),

            const SizedBox(width: AppSize.s16),

            // Text Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                      style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(
                      fontSize: FontSize.s18
                    ),
                  ),
                  const SizedBox(height: AppSize.s6),
                  Text(
                    subtitle,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(
                      color: ColorManager.white
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: AppSize.s46,
              height: AppSize.s46,
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(AppSize.s14),
              ),

              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AzkarCardWidgetsec extends StatelessWidget {
  final String title;
  final String subtitle;
  final Gradient backgroundGradient;
  final IconData icon;

  const AzkarCardWidgetsec({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundGradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p10),
      padding: const EdgeInsets.all(AppSize.s14),
      height: AppSize.s5,
      width: AppSize.s5,
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(AppSize.s24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Modern Icon Container
          Container(
            width: AppSize.s46,
            height: AppSize.s46,
            decoration: BoxDecoration(
              color: ColorManager.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppSize.s14),
            ),
            child: Icon(icon, color: ColorManager.white, size: AppSize.s26),
          ),

          const SizedBox(width: AppSize.s16),

          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  // style: TextStyle(
                  //   color: ColorManager.white,
                  //   fontSize: width * 0.045,
                  //   fontWeight: FontWeight.w600,
                  //   letterSpacing: 0.3,
                  // ),
                ),
                const SizedBox(height: AppSize.s6),
                Text(
                  subtitle,
                  // style: TextStyle(
                  //   color: ColorManager.white.withOpacity(0.85),
                  //   fontSize: width * 0.035,
                  // ),
                ),
              ],
            ),
          ),
          Container(
            width: AppSize.s46,
            height: AppSize.s46,
            decoration: BoxDecoration(
              color: ColorManager.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppSize.s14),
            ),

            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }
}

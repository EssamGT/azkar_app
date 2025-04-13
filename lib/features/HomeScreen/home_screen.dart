import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarScreen/AzkarListScreen.dart';
import 'package:azkar_app/features/Compas/presentation/widget/comaps.dart';
import 'package:azkar_app/features/CounterScreen/CounterScreen.dart';

import 'package:azkar_app/features/PrayingTimes/presentation/paying_times_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPage = 0;

  final List<Widget> _screens = <Widget>[
    AzkarListScreen(),
    PayingTimesScreen(),
    QiblaCompass(),
    NewCounterScreen(),
  ];

  onSelect(int index) {
    selectedPage = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(index: selectedPage, children: _screens),

        bottomNavigationBar: Stack(
          children: [
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     height: 80,
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //          Color(0xFF3B5998), // Steel Blue
            //           Color(0xFFAECDF2), // Light Cyan
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.topCenter,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                // color: ColorManager.blue, // Background color (for dark mode feel)
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, -4), // Shadow effect to create depth
                  ),
                ],
              ),

              height: AppSize.s80,
              child: GNav(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12,
                  vertical: AppPadding.p12,
                ),
                selectedIndex: selectedPage,
                onTabChange: (value) {
                  onSelect(value);
                },

                haptic: true,
                textSize: AppSize.s10,
                gap: AppSize.s15,
                iconSize: AppSize.s25,

                backgroundColor: ColorManager.black,
                color: ColorManager.lightGrey,

                activeColor: ColorManager.white,
                tabActiveBorder: Border.fromBorderSide(
                  BorderSide(
                    strokeAlign: AppSize.s2,
                    width: AppSize.s3,
                    color: ColorManager.white,
                  ),
                ),
                tabBorder: Border.fromBorderSide(
                  BorderSide(
                    strokeAlign: AppSize.s2,
                    width: AppSize.s3,
                    color: ColorManager.black,
                  ),
                ),
                hoverColor: ColorManager.black12,
                curve: Curves.easeInCirc,
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                tabBorderRadius: AppSize.s20,

                tabs: [
                  GButton(icon: Icons.home, text: StringsManager.home),
                  GButton(icon: Icons.mosque, text: StringsManager.prayerTimes),
                  GButton(
                    icon: LucideIcons.compass,
                    text: StringsManager.qiblaDiraction,
                  ),
                  GButton(
                    icon: Icons.touch_app_outlined,
                    text: StringsManager.counter,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

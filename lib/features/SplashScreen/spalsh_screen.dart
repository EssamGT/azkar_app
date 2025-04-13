import 'dart:async';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/core/routes/Routes.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _permissionsGranted = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final loc = await Permission.location.request();
    final notif = await Permission.notification.request();

    final granted = loc.isGranted && notif.isGranted;

    setState(() {
      _permissionsGranted = granted;
      _checked = true;
    });

    if (granted) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, Routes.homeScreen);
      });
    }
  }

  void _retryRequest() => _requestPermissions();
  void _openSettings() => openAppSettings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: ColorManager.blueGreenBackground,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child:
                  !_checked
                      ? SizedBox()
                      : _permissionsGranted
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ✅ Your App Icon
                          NeumorphicIcon(
                            Icons
                                .auto_awesome, // Replace with your app logo/icon
                            size: AppSize.s100,
                            style: NeumorphicStyle(
                              color: ColorManager.tealAccent,
                              depth: 12,
                              intensity: 1,
                            ),
                          ),
                          SizedBox(height:  AppSize.s24),
                          Text(
                            textDirection: TextDirection.ltr,
                            

                            StringsManager.welcome,
                            style: TextStyle(
                              fontSize: FontSize.s22,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.white,
                            ),
                          ),
                          SizedBox(height: AppSize.s12),
                          Text(
                            textDirection: TextDirection.ltr,
                            StringsManager.lunching,
                            style: TextStyle(color: ColorManager.white70),
                          ),
                        ],
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeumorphicIcon(
                            Icons.lock_outline_rounded,
                            size: AppSize.s100,
                            style: NeumorphicStyle(
                              color: ColorManager.white,
                              depth: 6,
                            ),
                          ),
                          SizedBox(height: AppSize.s24),
                          Text(
                            StringsManager.permissionRequired,
                            style: TextStyle(
                              fontSize: FontSize.s22,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.white,
                            ),
                          ),
                          SizedBox(height: AppSize.s12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p24
                            ),
                            child: Text(
                              StringsManager.whyPermissionRequired,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: ColorManager.white70),
                            ),
                          ),
                          SizedBox(height: AppSize.s32),
                          NeumorphicButton(
                            onPressed: _retryRequest,
                            style: NeumorphicStyle(
                              color: ColorManager.numeGreen,

                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(AppSize.s16),
                              ),
                              depth: 4,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppPadding.p14,
                              horizontal: AppPadding.p32,
                            ),
                            child: Text(
                              StringsManager.retry,
                              style: TextStyle(
                                color: ColorManager.black,
                                fontSize: AppSize.s16,
                              ),
                            ),
                          ),
                          SizedBox(height: AppSize.s16),
                          NeumorphicButton(
                            onPressed: _openSettings,
                            style: NeumorphicStyle(
                              color: ColorManager.redAccent,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(16),
                              ),
                              depth: 3,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: AppPadding.p14,
                              horizontal: AppPadding.p32,
                            ),
                            child: Text(
                              StringsManager.openSettings,
                              style: TextStyle(
                                color: ColorManager.white, 
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

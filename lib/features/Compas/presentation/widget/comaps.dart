import 'dart:math';
import 'package:azkar_app/core/resources/assets_manager.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math.dart' as m;

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({super.key});

  @override
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  double? qiblaDirection;
  double? _heading;
  bool _isCalibrated = true;

  @override
  void initState() {
    super.initState();
    _initQiblaDirection();
    _listenToCompass();
  }

  Future<void> _initQiblaDirection() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    final position = await Geolocator.getCurrentPosition();
    final direction = getQiblaDirection(position.latitude, position.longitude);
    setState(() {
      qiblaDirection = direction;
    });
  }

  double getQiblaDirection(double userLat, double userLng) {
    const kaabaLat = 21.4225;
    const kaabaLng = 39.8262;

    final userLatRad = m.radians(userLat);
    final userLngRad = m.radians(userLng);
    final kaabaLatRad = m.radians(kaabaLat);
    final kaabaLngRad = m.radians(kaabaLng);

    final deltaLng = kaabaLngRad - userLngRad;
    final y = sin(deltaLng) * cos(kaabaLatRad);
    final x =
        cos(userLatRad) * sin(kaabaLatRad) -
        sin(userLatRad) * cos(kaabaLatRad) * cos(deltaLng);
    final bearing = atan2(y, x);
    return (m.degrees(bearing) + 360) % 360;
  }

  void _listenToCompass() {
    FlutterCompass.events?.listen((event) {
      setState(() {
        _heading = event.heading;
      });

      if (_heading != null) {
        _checkCompassStability();
      }
    });
  }

  void _checkCompassStability() {
    const threshold = 10.0;
    if (_heading != null) {
      final previousHeading = _heading;
      if (previousHeading != null) {
        if ((previousHeading - _heading!).abs() > threshold) {
          setState(() {
            _isCalibrated = false;
          });
        } else {
          setState(() {
            _isCalibrated = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Scaffold(
        backgroundColor: ColorManager.comapsBackground,
        body:
            qiblaDirection == null
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<CompassEvent>(
                  stream: FlutterCompass.events,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.heading == null) {
                      return const Center(
                        child: Text(StringsManager.compasssnota),
                      );
                    }

                    final heading = snapshot.data!.heading!;
                    final angle =
                        ((qiblaDirection! - heading) * -1) * (pi / 180);
                    final diff = (qiblaDirection! - heading).abs();
                    // ignore: unused_local_variable
                    final isAligned = diff < 3;

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringsManager.qiblaDiraction,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              fontSize: FontSize.s22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppSize.s30),

                          // Calibration Status
                          _isCalibrated
                              ? Text(
                                StringsManager.compassCalirateGood,
                                style: TextStyle(
                                  fontSize: FontSize.s18,
                                  color: ColorManager.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                              : Column(
                                children: [
                                  Text(
                                    StringsManager.compassCalirateBad,
                                    style: TextStyle(
                                      fontSize: FontSize.s18,
                                      color: ColorManager.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    StringsManager.compassCalirateDO,
                                    style: TextStyle(
                                      fontSize: FontSize.s14,
                                      color: ColorManager.redAccent,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                          SizedBox(height: AppSize.s30),

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Neumorphic(
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  boxShape: const NeumorphicBoxShape.circle(),
                                  depth: 10,
                                  intensity: 0.7,
                                  surfaceIntensity: 0.6,
                                  lightSource: LightSource.topLeft,
                                  color: ColorManager.comapsBackground,
                                ),
                                child: Container(
                                  width: AppSize.s250,
                                  height: AppSize.s250,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: ColorManager.qiblaBackgeound,
                                      stops: const [0.3, 0.8],
                                    ),
                                  ),
                                  child: Transform.rotate(
                                    angle: angle,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          AssetsManager.compas,
                                          width: AppSize.s180,
                                          height: AppSize.s180,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.s32),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}

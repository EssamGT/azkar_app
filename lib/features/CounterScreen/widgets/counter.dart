import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:azkar_app/core/resources/assets_manager.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Counter extends StatelessWidget {
  final int count;
  const Counter({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: LottieBuilder.asset(
              AssetsManager.counterBackground,
              animate: true,
              frameRate: FrameRate(60),
              fit: BoxFit.cover,
              height: 300,
              repeat: true,
              
            ),
          ),
          Positioned(
            top: 1,
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedFlipCounter(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              wholeDigits: 5,
              fractionDigits: 0,
              hideLeadingZeroes: true,
              thousandSeparator: ',',
              textStyle: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
              ),
              value: count,
            ),
          ),
        ],
      ),
    );
  }
}

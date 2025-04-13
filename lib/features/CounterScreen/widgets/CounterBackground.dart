import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';



class CounterBackground extends StatelessWidget {
  const CounterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:ColorManager.blueGreenBackground
        ),
      ),
    
    );
  }
}

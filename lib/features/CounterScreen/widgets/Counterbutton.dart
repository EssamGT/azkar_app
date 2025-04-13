import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:azkar_app/core/resources/assets_manager.dart';

class Counterbutton extends StatefulWidget {
  final VoidCallback onTap;

  const Counterbutton({super.key, required this.onTap});

  @override
  State<Counterbutton> createState() => _CounterbuttonState();
}

class _CounterbuttonState extends State<Counterbutton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void _handleTap() {
    // Reset and play the animation
    _controller
      ..reset()
      ..fling(animationBehavior: AnimationBehavior.preserve);

    // Call the external tap function
    widget.onTap();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _handleTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Lottie.asset(
            AssetsManager.cButton,
            reverse: true,
            
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
            },
            height: 300,
          ),
        ),
      ),
    );
  }
}


class CounterClearebutton extends StatelessWidget {
  final Function onTap;
  const CounterClearebutton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: IconButton(
        splashRadius: 100,
        focusNode: FocusNode(),
        iconSize: AppSize.s50,
        onPressed: () => onTap(),
        icon: Icon(Icons.restart_alt_outlined,color: ColorManager.white,),
      ),
    );
  }
}

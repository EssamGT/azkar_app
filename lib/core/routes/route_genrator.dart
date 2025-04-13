import 'package:azkar_app/core/routes/Routes.dart';
import 'package:azkar_app/features/AzkarDetails/azkar_deatils.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:azkar_app/features/AzkarScreen/AzkarListScreen.dart';
import 'package:azkar_app/features/HomeScreen/home_screen.dart';
import 'package:azkar_app/features/SplashScreen/spalsh_screen.dart';

import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // case Routes.counterScreen:
      //   return MaterialPageRoute(builder: (_) => CounterScreen());
    
      case Routes.azkarScreen:
        return MaterialPageRoute(builder: (_) => AzkarListScreen());
      case Routes.azkarDetails:
       final args = settings.arguments as AzkarType;
        return MaterialPageRoute(builder: (_) => AzkarDetailsScreen(azkarType: args,),);
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('No Route Found')),
            body: const Center(child: Text('No Route Found')),
          ),
    );
  }
}

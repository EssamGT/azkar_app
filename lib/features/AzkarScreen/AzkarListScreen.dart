import 'package:animation_list/animation_list.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/features/AzkarScreen/widget/AzkarCard.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:flutter/material.dart';

class AzkarListScreen extends StatelessWidget {
  AzkarListScreen({super.key});

  final List<AzkarType> type = [
    AzkarType.morning,
    AzkarType.night,
    AzkarType.mosque,
    AzkarType.praying,
    AzkarType.wakeUp,
    AzkarType.sleep,
    AzkarType.saving,
    AzkarType.mostazed,
    AzkarType.ahadeth,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  elevation: 0,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xFF3B5998), // Steel Blue
        //         Color(0xFFAECDF2), // Light Cyan
        //       ],
        //       begin: Alignment.topCenter,
        //       end: Alignment.topCenter,
        //     ),
        //   ),
        // ),
        title: Text(StringsManager.azkark),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimationList(
               
              animationDirection: AnimationDirection.vertical,
              duration: 2200,
              reBounceDepth: 10.0,
              children:
                  type.map((item) {
                    return azkarCard(azkarType: item);
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

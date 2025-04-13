import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/azkar_options_menu.dart';
import 'package:azkar_app/features/CounterScreen/cubit/counter_view_model_cubit.dart';
import 'package:azkar_app/features/CounterScreen/widgets/CounterBackground.dart';
import 'package:azkar_app/features/CounterScreen/widgets/Counterbutton.dart';
import 'package:azkar_app/features/CounterScreen/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:vibration/vibration.dart';

class NewCounterScreen extends StatelessWidget {
  const NewCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterViewModelCubit()..ini(),
      child: BlocBuilder<CounterViewModelCubit, CounterViewModelState>(
        builder: (context, state) {
          var cubit = CounterViewModelCubit.get(context);
          if (state is Add) {
            return Scaffold(
              appBar: customAppBar(context, cubit),

              body: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        CounterBackground(),

                        Positioned(
                          bottom: 1,
                          right: 1,
                          left: 1,
                          child: Counterbutton(
                            onTap: () async {
                              cubit.add();
                              if (cubit.vibrate) {
                                if (cubit.vibrationLimit()) {
                                  if (await Vibration.hasAmplitudeControl()) {
                                    Vibration.vibrate(
                                      pattern: [0, 200, 100, 300],
                                      intensities: [
                                        64,
                                        255,
                                      ], // Low to high intensity
                                    );
                                  } else {
                                    Vibration.vibrate(
                                      pattern: [300, 200, 200, 300],
                                    );
                                  }
                                }
                              }
                            },
                          ),
                        ),

                        CounterClearebutton(onTap: () => cubit.clear()),
                        Positioned(
                          top: 1,
                          left: 0,
                          right: 0,
                          child: Counter(count: cubit.counter),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  PreferredSizeWidget customAppBar(BuildContext context, var cubit) {
    // var cubit = CounterViewModelCubit.get(context);
    return AppBar(
      //  elevation: 0,
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //     Color(0xFF3B5998), // Steel Blue
      //         Color(0xFFAECDF2), // Light Cyan
      //         ],
      //       begin: Alignment.topCenter,
      //       end: Alignment.topCenter,
      //     ),
      //   ),
      // ),
      backgroundColor: ColorManager.black,
      title: Text(
        StringsManager.counter,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        cubit.vibrate
            ? TextButton(
              onPressed: () {
                showZekrtDialog(context);
              },
              child: Text(
                '${StringsManager.vabrationLimitSet} ${cubit.vibrateLimt}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            )
            : Container(),
        IconButton(
          onPressed: () {
            cubit.enableDisableVibration();
          },
          icon: Icon(
            cubit.vibrate ? Icons.vibration : LucideIcons.vibrateOff,
            color: ColorManager.white,
            size: AppSize.s30,
          ),
        ),
      ],
    );
  }

  void showZekrtDialog(BuildContext context) {
    var cubit = CounterViewModelCubit.get(context);

    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _countcontroller = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Center(
          child: AlertDialog(
            titleTextStyle: TextStyle(
              color: ColorManager.black,
              fontSize: FontSize.s18,
            ),
            title: Text(StringsManager.vibrationLimte),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return StringsManager.cantBeEmpty;
                      }

                      return null; // no error
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: ColorManager.black),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s15),
                        borderSide: BorderSide(color: ColorManager.blue),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s15),
                        borderSide: BorderSide(color: ColorManager.black),
                      ),

                      label: Text(StringsManager.vibrationLimte),
                    ),
                    cursorColor: ColorManager.grey,
                    controller: _countcontroller,
                  ),

                  SizedBox(height: AppSize.s10),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s15),
                      color: ColorManager.lightBlue,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.vibrateLimt = int.parse(_countcontroller.text);
                          Navigator.of(context).pop();
                          toastt(
                            '${StringsManager.vibrationSetDone} ${_countcontroller.text}',
                          );
                        }
                      },
                      child: Text(StringsManager.makeit),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

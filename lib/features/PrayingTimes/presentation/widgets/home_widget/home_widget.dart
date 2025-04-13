import 'package:azkar_app/core/di/di.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/manager/cubit/praying_times_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/c_rem_Time.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/prayr_ext.dart';

// ignore: must_be_immutable
class HomeWidget extends StatelessWidget {
  final NewPrayerTimesEntity entity;
  final CRemTime next;
  HomeWidget({super.key, required this.entity, required this.next});
  int todayindex = DateTime.now().day - 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<PrayingTimesViewModelCubit>(),
      child:
          BlocBuilder<PrayingTimesViewModelCubit, PrayingTimesViewModelState>(
            builder: (context, state) {
              // Whenever the state changes, the widget will update
              return Container(
                height: 125,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s15),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: ColorManager.homeWidgetBackground,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: AppSize.s10),
                            Text(
                              next.prayTime ,
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall!.copyWith(
                                fontSize: FontSize.s16,
                                color: ColorManager.gold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(width: AppSize.s10),
                            Text(
                              next.prayName ,
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall!.copyWith(
                                fontSize: FontSize.s16,
                                color: ColorManager.gold,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(width: AppSize.s10),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            prayTime(
                              context,
                              entity.data?[todayindex].timings?.isha ?? '',
                              StringsManager.isha,
                            ),
                            prayTime(
                              context,
                              entity.data?[todayindex].timings?.maghrib ?? '',
                              StringsManager.maghrib,
                            ),
                            prayTime(
                              context,
                              entity.data?[todayindex].timings?.asr ?? '',
                              StringsManager.asr,
                            ),
                            prayTime(
                              context,
                              entity.data?[todayindex].timings?.dhuhr ?? '',
                              StringsManager.duhur,
                            ),
                            prayTime(
                              context,
                              entity.data?[todayindex].timings?.fajr ?? '',
                              StringsManager.fajr,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget prayTime(BuildContext context, String time, String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: Icon(getPrayerIcon(name), color: ColorManager.gold)),
        SizedBox(height: AppSize.s5),
        Center(
          child: Text(
            name,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: FontSize.s10,
              color: ColorManager.gold,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        SizedBox(height: AppSize.s2),
        Center(
          child: Text(
            convertUtcTo12Hour(time),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: FontSize.s10,
              color: ColorManager.gold,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}

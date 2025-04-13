import 'package:azkar_app/core/cache/prefs_helper.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/c_rem_Time.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/manager/cubit/praying_times_view_model_cubit.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/home_widget/home_widget.dart '
    as home;
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/home_widget/home_widget_config.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/times_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
//Done

class NextPrayingTime extends StatefulWidget {
  final NewPrayerTimesEntity nextTime;
  const NextPrayingTime({super.key, required this.nextTime});

  @override
  State<NextPrayingTime> createState() => _NextPrayingTimeState();
}

class _NextPrayingTimeState extends State<NextPrayingTime> {
  @override
  void initState() {
    PrayingTimesViewModelCubit.get(context).startPrayerTimer();
    HomeWidgetConfig.initialize();

    super.initState();
  }

  // callUpdateUI([CRemTime? next]) async {
  //   await HomeWidgetConfig.update(
  //     context,
  //     home.HomeWidget(entity: widget.nextTime, next: next),
  //   );
  // }

  updateUI(CRemTime next, NewPrayerTimesEntity nextTime) async {
    BlocProvider.of<PrayingTimesViewModelCubit>(context).triggerWidgetUpdate(
      context,
      home.HomeWidget(entity: nextTime, next: next),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayingTimesViewModelCubit, PrayingTimesViewModelState>(
      buildWhen: (previous, current) {
        if (current is NextPrayerSucsses ||
            current is NextPrayerError ||
            current is NextPrayerLoading) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is NextPrayerSucsses) {
          print('hhhhh');
          updateUI(state.remTime, widget.nextTime);

          return Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: _buildNextPrayerCard(
              context,
              state.remTime.prayName,
              state.remTime.prayTime,
              state.remTime.remH,
              state.remTime.remMIn,
            ),
          );
        }
        if (state is NextPrayerError) {
          return looading(Text(state.error));
        }
        return looading(CircularProgressIndicator());
      },
    );
  }

  Widget _buildNextPrayerCard(
    BuildContext context,
    String name,
    String time,
    String remaingTimeH,
    String remaingTimeM,
  ) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          bool enable = PrefsHelper.getButton();
          PrefsHelper.setButton(!enable);
          PrayingTimesViewModelCubit.get(context).cahedPrayer();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              todayColumn(context),
              getaddressRow(context),
              Text(
                textDirection: TextDirection.rtl,
                "${StringsManager.nextPray} :",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSize.s4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    textDirection: TextDirection.rtl,
                    time,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textDirection: TextDirection.ltr,

                    StringsManager.remaningTime,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  timeRow(remaingTimeH, remaingTimeM, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget looading(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        padding: const EdgeInsets.all(20),

        child: Center(child: child),
      ),
    );
  }

  Widget getaddressRow(BuildContext context) {
    var cubit = PrayingTimesViewModelCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.location_pin, color: ColorManager.white),
          Text(cubit.address, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }

  Widget todayColumn(context) {
    String hijriDay = widget.nextTime.data?[todayIndex].date?.hijri?.day ?? '';
    String hijriMonth =
        widget.nextTime.data?[todayIndex].date?.hijri?.month?.ar ?? '';
    String hijriYear =
        widget.nextTime.data?[todayIndex].date?.hijri?.year ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(hijriDay, style: Theme.of(context).textTheme.labelSmall),
        SizedBox(width: AppSize.s5),
        Text(hijriMonth, style: Theme.of(context).textTheme.labelSmall),
        SizedBox(width: AppSize.s5),
        Text(hijriYear, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }

  Widget timeRow(String hour, String min, context) {
    String hourText = '';
    String minText = '';

    if (hour != '0') {
      if (hour == '1') {
        hourText = 'ساعة';
      }
      if (hour == '2') {
        hourText = 'ساعتين';
      } else {
        hourText = '$hour ساعات';
      }
    }

    // تحويل الدقائق إلى صيغة عربية
    if (min != '0') {
      minText = '$min ${min == '1' ? 'دقيقة' : 'دقائق'}';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          textDirection: TextDirection.rtl,
          '$hourText${hourText.isNotEmpty && minText.isNotEmpty ? ' و ' : ''}$minText',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontSize: FontSize.s14),
        ),
      ],
    );
  }
}

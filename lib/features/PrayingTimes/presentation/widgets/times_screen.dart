import 'package:azkar_app/core/cache/prefs_helper.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/PrayingTimes/data/models/PrayingTimesModel/new_prayer_times_response.dart';
import 'package:azkar_app/features/PrayingTimes/domain/Entity/new_prayer_times_response_entity.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/next_pray_screen.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/prayr_ext.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

//d one
class TimesScreen extends StatefulWidget {
  final NewPrayerTimesEntity times;
  const TimesScreen({super.key, required this.times});

  @override
  State<TimesScreen> createState() => _TimesScreenState();
}

int todayIndex = DateTime.now().day - 1;
int slectedIndex = todayIndex;

class _TimesScreenState extends State<TimesScreen> {
  next(int maxIndex) {
    if (slectedIndex < maxIndex) {
      slectedIndex++;
      setState(() {});
    }
  }

  back(int maxIndex) {
    if (slectedIndex > 0 && slectedIndex <= maxIndex) {
      slectedIndex--;
      setState(() {});
    }
  }

  int getMaxIndex() {
    return widget.times.data!.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // MaterialButton(
        //   onPressed: () async {
        //     PrayingTimesViewModelCubit.get(context).getNextPray();
        //   },
        //   child: Text('dadadd'),
        // ),
        // theSwitchButton(), to do on settings
        NextPrayingTime(nextTime: widget.times),
        neumorphicButton(),
        PrefsHelper.getButton() ? pryerTimesAdColumn() : pryerTimesColumn(),
      ],
    );
  }

  Widget theSwitchButton() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: NeumorphicSwitch(
        value: PrefsHelper.getButton(),
        style: NeumorphicSwitchStyle(
          activeThumbColor: ColorManager.lightWhite,
          activeTrackColor: ColorManager.transparent,
          inactiveThumbColor: ColorManager.transparent,
          inactiveTrackColor: ColorManager.transparent,
        ),
        onChanged: (value) {
          PrefsHelper.setButton(value);
          setState(() {});
        },
      ),
    );
  }

  Widget pryerTimesColumn() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.lightWhite,
          borderRadius: BorderRadius.circular(AppSize.s30),
          border: Border.all(
            color: ColorManager.white.withOpacity(0.80),
            width: AppSize.s2,
          ),
        ),

        child: Column(
          children: _buildPrayerTimeCards(
            widget.times.data?[slectedIndex].timings,
          ),
        ),
      ),
    );
  }

  Widget pryerTimesAdColumn() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.lightWhite,
          borderRadius: BorderRadius.circular(AppSize.s30),
          border: Border.all(
            color: ColorManager.white.withOpacity(0.80),
            width: AppSize.s2,
          ),
        ),

        child: Column(
          children: _buildAdPrayerTimeCards(
            widget.times.data?[slectedIndex].timings,
          ),
        ),
      ),
    );
  }

  Widget timesRow(String text, String time) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.white.withOpacity(0.60),
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  border: Border.all(
                    color: ColorManager.white.withOpacity(0.80),
                    width: AppSize.s2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Icon(getPrayerIcon(text), size: AppSize.s35),
                ),
              ),
              SizedBox(width: AppSize.s10),
              Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),

          Text(
            textDirection: TextDirection.rtl,
            convertUtcTo12Hour(time),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPrayerTimeCards(Timings? prayerTimes) {
    return [
      timesRow(StringsManager.fajr, prayerTimes?.fajr ?? ''),

      timesRow(StringsManager.sunrise, prayerTimes?.sunrise ?? ''),
      timesRow(StringsManager.duhur, prayerTimes?.dhuhr ?? ''),
      timesRow(StringsManager.asr, prayerTimes?.asr ?? ''),
      timesRow(StringsManager.maghrib, prayerTimes?.maghrib ?? ''),
      timesRow(StringsManager.isha, prayerTimes?.isha ?? ''),
    ];
  }

  List<Widget> _buildAdPrayerTimeCards(Timings? prayerTimes) {
    return [
      timesRow(StringsManager.fajr, prayerTimes?.fajr ?? ''),
      timesRow(StringsManager.sunrise, prayerTimes?.sunrise ?? ''),
      timesRow(StringsManager.duhur, prayerTimes?.dhuhr ?? ''),
      timesRow(StringsManager.asr, prayerTimes?.asr ?? ''),
      timesRow(StringsManager.maghrib, prayerTimes?.maghrib ?? ''),
      timesRow(StringsManager.isha, prayerTimes?.isha ?? ''),
      timesRow(StringsManager.firstThird, prayerTimes?.firstthird ?? ''),
      timesRow(StringsManager.midNight, prayerTimes?.midnight ?? ''),
      timesRow(StringsManager.lastThird, prayerTimes?.lastthird ?? ''),
    ];
  }

  Widget neumorphicButton() {
    String arDay =
        widget.times.data?[slectedIndex].date?.hijri?.weekday?.ar ?? '';
    String daynum =
        int.parse(
          widget.times.data?[slectedIndex].date?.gregorian?.day ?? '',
        ).toString();
    String month = getMonthName(
      widget.times.data?[slectedIndex].date?.gregorian?.month?.number ?? 13,
    );

    return Neumorphic(
      style: NeumorphicStyle(
        depth: 2,
        intensity: 0.8,
        surfaceIntensity: 0.15,
        shadowLightColor: ColorManager.lightWhite,
        shadowDarkColor: ColorManager.black.withOpacity(0.3),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
        color: ColorManager.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s20,
          vertical: AppSize.s10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicButton(
              onPressed: () => {next(getMaxIndex())},
              style: NeumorphicStyle(
                depth: 4, // Soft raised effect
                intensity: 0.8, // Softer intensity for a clean look
                boxShape:
                    NeumorphicBoxShape.circle(), // Circular shape without border
                color: Colors.transparent, // No background color
                shadowLightColor: ColorManager.white.withOpacity(
                  0.4,
                ), // Light shadow
                shadowDarkColor: ColorManager.black.withOpacity(
                  0.4,
                ), // Dark shadow for depth
              ),
              child: NeumorphicIcon(
                Icons.chevron_right, // Switched the left and right arrows
                size: AppSize.s24,
                style: NeumorphicStyle(depth: 1, color: ColorManager.white),
              ),
            ),
            SizedBox(width: AppSize.s10),
            slectedIndex == todayIndex
                ? Text(
                  textDirection: TextDirection.ltr,
                  ' :  ${StringsManager.today} ',
                  style: Theme.of(context).textTheme.labelSmall,
                )
                : slectedIndex > todayIndex
                ? Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Icon(Icons.arrow_back),
                )
                : SizedBox(),
            Text(
              arDay, // Arabic date text
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(width: AppSize.s5),
            Text(
              daynum, // Arabic date text
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(width: AppSize.s5),
            Text(
              month, // Arabic date text
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(width: AppSize.s10),
            slectedIndex < todayIndex
                ? Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: Icon(Icons.arrow_forward),
                )
                : SizedBox(),
            NeumorphicButton(
              onPressed: () => back(getMaxIndex()),
              style: NeumorphicStyle(
                depth: 4,
                intensity: 0.8,
                boxShape: NeumorphicBoxShape.circle(),
                color: ColorManager.transparent,
                shadowLightColor: ColorManager.white.withOpacity(0.4),
                shadowDarkColor: ColorManager.black.withOpacity(0.4),
              ),
              child: NeumorphicIcon(
                Icons.chevron_left,
                size: AppSize.s24,
                style: NeumorphicStyle(depth: 1, color: ColorManager.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

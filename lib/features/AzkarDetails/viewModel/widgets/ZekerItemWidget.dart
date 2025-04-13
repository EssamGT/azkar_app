import 'package:azkar_app/core/cache/prefs_helper.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/get_app_titile.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';

class ZekerItemWidget extends StatelessWidget {
  final Zekr zeker;
  final AzkarType type;
  final Animation<double> animation;
  final Function onClick;
  const ZekerItemWidget({
    super.key,
    required this.zeker,
    required this.type,
    required this.animation,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),

      child: item(context),
    );
  }

  Widget item(BuildContext context) {
    return MaterialButton(
      onPressed: () => onClick(),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s24),
            boxShadow: [
              BoxShadow(
                color: ColorManager.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                zeker.text,
                textAlign: TextAlign.right,
          textDirection: TextDirection.ltr, 

                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: PrefsHelper.getFontSize(),
                ),
              ),
              const SizedBox(height: AppSize.s24),
              const Divider(),

              const SizedBox(height: AppSize.s12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: AppSize.s40,
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: azkarColorFromType(type),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: AppSize.s30,
                      height: AppSize.s30,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        '${zeker.count}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share(zeker.text);
                      Vibration.vibrate(pattern: [80, 70, 60]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

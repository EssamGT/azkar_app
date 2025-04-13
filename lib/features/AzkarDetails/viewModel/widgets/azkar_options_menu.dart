import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/ZekerItemWidget.dart';
import 'package:azkar_app/features/AzkarScreen/widget/add_dialog.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/cubit/azkar_details_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';

// ignore: must_be_immutable
class AzkarOptionsMenu extends StatelessWidget {
  final Zekr zekr;
  final AzkarType type;
  final Animation<double> animation;
  final Function onClick;
  final int index;

  const AzkarOptionsMenu({
    super.key,
    required this.zekr,
    required this.type,
    required this.animation,
    required this.onClick,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: GestureDetector(
        onLongPress: () {
          azkarOptionsMenu(context);
          Vibration.vibrate(pattern: [100, 150, 150]);
        },
        child: ZekerItemWidget(
          animation: animation,
          onClick: onClick,
          type: type,
          zeker: zekr,
        ),
      ),
    );
  }

  Future azkarOptionsMenu(BuildContext context) {
    var cubit = AzkarDetailsViewModelCubit.get(context);
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                zekr.added
                    ? [
                      ListTile(
                        leading: Icon(Icons.copy),
                        title: Text(StringsManager.copy),
                        onTap: () {
                          copyToClipord(zekr.text, context);
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.share),
                        title: Text(StringsManager.share),
                        onTap: () {
                          Share.share(zekr.text);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.edit),
                        title: Text(StringsManager.edit),
                        onTap: () {
                          Navigator.of(context).pop();
                          showZekrtDialog(context, type, zekr);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text(StringsManager.delete),
                        onTap: () {
                          cubit.deleteZekr(zekr, index);
                          Navigator.of(context).pop();
                          toastt(StringsManager.dletedSuc);
                        },
                      ),
                    ]
                    : [
                      ListTile(
                        leading: Icon(Icons.copy),
                        title: Text(StringsManager.copy),
                        onTap: () {
                          copyToClipord(zekr.text, context);
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.share),
                        title: Text(StringsManager.share),
                        onTap: () {
                          Share.share(zekr.text);

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
          ),
        );
      },
    );
  }
}

copyToClipord(String text, BuildContext context) async {
  final String textToCopy = text;
  if (textToCopy.isNotEmpty) {
    try {
      await Clipboard.setData(ClipboardData(text: textToCopy));
      Fluttertoast.showToast(
        msg: StringsManager.copyDone,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.grey,
        textColor: ColorManager.white,
        fontSize: FontSize.s16,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: StringsManager.copyFail,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.grey,
        textColor: ColorManager.white,
        fontSize: FontSize.s16,
      );
    }
  }
}

toastt(String m) {
  return Fluttertoast.showToast(
    msg: m,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ColorManager.grey,
    textColor: ColorManager.white,
    fontSize: FontSize.s16,
  );
}

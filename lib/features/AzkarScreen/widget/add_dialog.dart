import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/core/resources/strings_manager.dart';
import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/cubit/azkar_details_view_model_cubit.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/azkar_options_menu.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/get_app_titile.dart';
import 'package:flutter/material.dart';

void showZekrtDialog(BuildContext context, AzkarType type, [Zekr? zekr]) {
  // ignore: no_leading_underscores_for_local_identifiers
  TextEditingController _textcontroller = TextEditingController();
  // ignore: no_leading_underscores_for_local_identifiers
  TextEditingController _countcontroller = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
  if (zekr?.text != null && zekr?.count != null) {
    _textcontroller.text = zekr!.text;
    _countcontroller.text = zekr.count.toString();
  }
  var cubit = AzkarDetailsViewModelCubit.get(context);
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Center(
        child: AlertDialog(
          titleTextStyle: TextStyle(
            color: ColorManager.black,
            fontSize: FontSize.s18,
          ),
          title: Text(StringsManager.addNew),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator:
                      (value) => getValidator(AzkarValidaotr.zekrText, value!),

                  minLines: 5,
                  maxLines: 10,
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
                    label: Text(StringsManager.enterZekr),
                  ),
                  cursorColor: ColorManager.grey,

                  controller: _textcontroller,
                ),
                SizedBox(height: AppSize.s10),
                TextFormField(
                  validator: (value) => getValidator(AzkarValidaotr.zekrCount, value!),
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

                    label: Text(StringsManager.enterZekrCount),
                  ),
                  cursorColor: ColorManager.grey,
                  controller: _countcontroller,
                ),

              const  SizedBox(height: AppSize.s10),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s15),
                    gradient: LinearGradient(colors: azkarColorFromType(type)),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                     if(formKey.currentState!.validate()){
                        if (zekr?.text != null && zekr?.count != null) {
                          cubit.editZekr(
                            zekr!,
                            _textcontroller.text,
                            int.parse(_countcontroller.text),
                          );
                          Navigator.of(context).pop();

                          toastt(StringsManager.editSuc);
                        } else {
                          cubit.addZekr(
                            _textcontroller.text,
                            int.parse(_countcontroller.text),
                            type,
                          );

                          Navigator.of(context).pop();
                          toastt(StringsManager.addSuc);
                        }
                     }
                    },
                    child: Text(StringsManager.addIt,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
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

enum AzkarValidaotr { zekrText, zekrCount }

 getValidator(AzkarValidaotr valid, String vv) {
  switch (valid) {
    case AzkarValidaotr.zekrText:
      if ( vv.length>5) {
        return null;
      } else {
        return StringsManager.valTEror;
      }
    case AzkarValidaotr.zekrCount:
      if (vv.isNotEmpty&&vv.length<=1000) {
        return null;
      } else {
        return StringsManager.valTEror;
      }
  }
}

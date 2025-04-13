import 'package:azkar_app/core/resources/values_manager.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/cubit/azkar_details_view_model_cubit.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/finishing_widget.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/get_app_titile.dart';
import 'package:azkar_app/features/AzkarDetails/viewModel/widgets/azkar_options_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AzkarDetailsScreen extends StatelessWidget {


  AzkarType azkarType;
  AzkarDetailsScreen({super.key, required this.azkarType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AzkarDetailsViewModelCubit()..getAzkarList(azkarType),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<
            AzkarDetailsViewModelCubit,
            AzkarDetailsViewModelState
          >(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AzkarDetailsViewModelCubit.get(context);

              if (state is Succsess) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      getAppTitle(azkarType, context, ),

                      const SizedBox(height: AppSize.s20),

                      AnimatedList(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        key: cubit.listKey,
                        initialItemCount: state.azkarList.length,
                        itemBuilder: (context, index, animation) {
                          return AzkarOptionsMenu(
                            
                            zekr: state.azkarList[index],
                            type: azkarType,
                            animation: animation,
                            index: index,
                            onClick:
                                () => cubit.onTap(
                                  index,
                                  azkarType,
                                ),
                                
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              if (state is Finsish) {
                return finishingWidget(state, azkarType, context);
              }
              if (state is Error) {
                Center(child: Text(state.error));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}



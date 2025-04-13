import 'package:azkar_app/core/di/di.dart';
import 'package:azkar_app/core/resources/color_manager.dart';
import 'package:azkar_app/core/resources/font_manager.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/manager/cubit/praying_times_view_model_cubit.dart';
import 'package:azkar_app/features/PrayingTimes/presentation/widgets/times_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayingTimesScreen extends StatelessWidget {
  const PayingTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => getIt.get<PrayingTimesViewModelCubit>()..cahedPrayer(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient:  LinearGradient(
            begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:ColorManager.blueGreenBackground
            ),
          ),
          child: BlocBuilder<
            PrayingTimesViewModelCubit,
            PrayingTimesViewModelState
          >(
            buildWhen: (previous, current) {
              if (current is Sucsses ||
                  current is Error ||
                  current is Loading) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state is Sucsses) {
                
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                  ),
                  child: RefreshIndicator(
                    backgroundColor: ColorManager.transparent,
                    color: ColorManager.white,
                    onRefresh:
                        () =>
                            PrayingTimesViewModelCubit.get(
                              context,
                            ).getPrayingTimes(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.zero,
                      children: [TimesScreen(times: state.entity)],
                    ),
                  ),
                );
              }
              if (state is Error) {
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                  ),
                  child: RefreshIndicator(
                    backgroundColor: ColorManager.transparent,
                    color: ColorManager.white,
                    onRefresh:
                        () =>
                            PrayingTimesViewModelCubit.get(
                              context,
                            ).getPrayingTimes(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.zero,
                      children: [
                      
                        SizedBox(
                          height:
                              MediaQuery.of(
                                context,
                              ).size.height, 
                          child: Center(
                          
                            child: Text(
                              state.error,
                              style: TextStyle(
                                fontSize:
                                    FontSize.s20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

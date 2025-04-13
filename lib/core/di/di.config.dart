// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/PrayingTimes/data/DataSource/daw.dart' as _i1048;
import '../../features/PrayingTimes/data/DataSource/DawImpl/daw_impl.dart'
    as _i1020;
import '../../features/PrayingTimes/data/repository/praying_times_repo_impl.dart'
    as _i340;
import '../../features/PrayingTimes/domain/repository/praying_times_repo.dart'
    as _i354;
import '../../features/PrayingTimes/domain/UseCase/use_case.dart' as _i17;
import '../../features/PrayingTimes/presentation/manager/cubit/praying_times_view_model_cubit.dart'
    as _i1020;
import '../remote/api_manager.dart' as _i822;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i822.ApiManager>(() => _i822.ApiManager());
    gh.factory<_i1048.Daw>(() => _i1020.DawImpl(gh<_i822.ApiManager>()));
    gh.factory<_i354.PrayingTimesRepo>(
        () => _i340.PrayingTimesRepoImpl(gh<_i1048.Daw>()));
    gh.factory<_i17.UseCase>(() => _i17.UseCase(gh<_i354.PrayingTimesRepo>()));
    gh.factory<_i1020.PrayingTimesViewModelCubit>(
        () => _i1020.PrayingTimesViewModelCubit(gh<_i17.UseCase>()));
    return this;
  }
}

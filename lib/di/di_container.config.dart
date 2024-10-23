// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checker/di/injector_module.dart' as _i5;
import 'package:checker/presentation/screens/main_screen/controller/mobx_main_screen_controller.dart'
    as _i4;
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectorModule = _$InjectorModule();
    gh.singleton<_i3.Dio>(() => injectorModule.getDio());
    gh.lazySingleton<_i4.MobxMainScreenController>(
        () => _i4.MobxMainScreenController());
    return this;
  }
}

class _$InjectorModule extends _i5.InjectorModule {}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checker/core/di/injector_module.dart' as _i432;
import 'package:checker/core/routing/go_router_provider.dart' as _i843;
import 'package:checker/feature/game_screen/application/game_screen_service.dart'
    as _i327;
import 'package:checker/feature/game_screen/application/igame_screen_service.dart'
    as _i762;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    final injectorModule = _$InjectorModule();
    gh.singleton<_i361.Dio>(() => injectorModule.getDio());
    gh.lazySingleton<_i843.GoRouterProvider>(() => _i843.GoRouterProvider());
    gh.lazySingleton<_i762.IGameScreenService>(() => _i327.GameScreenService());
    return this;
  }
}

class _$InjectorModule extends _i432.InjectorModule {}

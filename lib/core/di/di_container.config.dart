// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:checker/common/game_session_feature/data/api/game_session_api.dart'
    as _i820;
import 'package:checker/common/game_session_feature/data/data_source/iwebsocket_data_source.dart'
    as _i597;
import 'package:checker/common/game_session_feature/data/data_source/websocket_data_source.dart'
    as _i571;
import 'package:checker/common/game_session_feature/data/repository/game_repository.dart'
    as _i122;
import 'package:checker/common/game_session_feature/data/repository/igame_repository.dart'
    as _i212;
import 'package:checker/common/game_session_feature/mapper/connect_to_game_mapper.dart'
    as _i391;
import 'package:checker/common/game_session_feature/mapper/game_cell_mapper.dart'
    as _i343;
import 'package:checker/common/game_session_feature/mapper/game_checker_mapper.dart'
    as _i686;
import 'package:checker/common/game_session_feature/mapper/game_field_mapper.dart'
    as _i491;
import 'package:checker/common/game_session_feature/mapper/game_session_item_mapper.dart'
    as _i145;
import 'package:checker/common/game_session_feature/mapper/game_session_mapper.dart'
    as _i195;
import 'package:checker/common/user_feature/data/api/user_api.dart' as _i742;
import 'package:checker/common/user_feature/data/repository/iuser_repository.dart'
    as _i311;
import 'package:checker/common/user_feature/data/repository/user_repository.dart'
    as _i649;
import 'package:checker/core/di/injector_module.dart' as _i432;
import 'package:checker/core/routing/go_router_provider.dart' as _i843;
import 'package:checker/feature/create_new_game/application/create_new_game_service.dart'
    as _i1055;
import 'package:checker/feature/create_new_game/application/icreate_new_game_service.dart'
    as _i1007;
import 'package:checker/feature/create_new_game/data/api/create_game_session_api.dart'
    as _i1070;
import 'package:checker/feature/create_new_game/data/create_new_game_repository/create_new_game_repository.dart'
    as _i723;
import 'package:checker/feature/create_new_game/data/create_new_game_repository/icreate_new_game_repository.dart'
    as _i806;
import 'package:checker/feature/create_new_game/presentation/controller/create_new_game_controller.dart'
    as _i313;
import 'package:checker/feature/game_screen/application/game_screen_service.dart'
    as _i327;
import 'package:checker/feature/game_screen/application/igame_screen_service.dart'
    as _i762;
import 'package:checker/feature/game_screen/data/api/game_screen_api.dart'
    as _i605;
import 'package:checker/feature/game_screen/data/repository/ionline_game_repository.dart'
    as _i709;
import 'package:checker/feature/game_screen/data/repository/online_game_repository.dart'
    as _i348;
import 'package:checker/feature/main_screen/application/imain_service.dart'
    as _i1006;
import 'package:checker/feature/main_screen/application/main_service.dart'
    as _i808;
import 'package:checker/feature/main_screen/data/api/main_api.dart' as _i811;
import 'package:checker/feature/main_screen/data/repository/imain_repository.dart'
    as _i1032;
import 'package:checker/feature/main_screen/data/repository/main_repository.dart'
    as _i1034;
import 'package:checker/feature/server_sessions_screeen/application/game_list_api_service.dart'
    as _i91;
import 'package:checker/feature/server_sessions_screeen/application/igame_list_api_service.dart'
    as _i515;
import 'package:checker/feature/server_sessions_screeen/data/api/server_sessions_api.dart'
    as _i303;
import 'package:checker/feature/server_sessions_screeen/data/repository/iserver_sessions_repository.dart'
    as _i535;
import 'package:checker/feature/server_sessions_screeen/data/repository/server_sessions_repository.dart'
    as _i101;
import 'package:checker/feature/win_game_dialog/application/win_game_dialog_service.dart'
    as _i579;
import 'package:checker/feature/win_game_dialog/data/api/win_game_dialog_api.dart'
    as _i1071;
import 'package:checker/feature/win_game_dialog/data/repository/win_game_session_dialog_repository.dart'
    as _i463;
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
    gh.factory<_i686.GameCheckerMapper>(() => _i686.GameCheckerMapper());
    gh.factory<_i391.ConnectToGameMapper>(() => _i391.ConnectToGameMapper());
    gh.factory<_i195.GameSessionMapper>(() => _i195.GameSessionMapper());
    gh.factory<_i491.GameFieldMapper>(() => _i491.GameFieldMapper());
    gh.factory<_i343.GameCellMapper>(() => _i343.GameCellMapper());
    gh.factory<_i145.GameSessionItemMapper>(
        () => _i145.GameSessionItemMapper());
    gh.singleton<String>(() => injectorModule.baseUrl);
    gh.singleton<_i361.Dio>(() => injectorModule.getDio());
    gh.lazySingleton<_i843.GoRouterProvider>(() => _i843.GoRouterProvider());
    gh.lazySingleton<_i597.IWebsocketDataSource>(
        () => _i571.WebsocketDataSource());
    gh.lazySingleton<_i742.UserApi>(() => _i742.UserApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i820.GameSessionApi>(() => _i820.GameSessionApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i303.ServerSessionsApi>(() => _i303.ServerSessionsApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i605.GameScreenApi>(() => _i605.GameScreenApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i811.MainApi>(() => _i811.MainApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i1070.CreateGameSessionApi>(
        () => _i1070.CreateGameSessionApi(
              gh<_i361.Dio>(),
              baseUrl: gh<String>(),
            ));
    gh.factory<_i1071.WinGameDialogApi>(() => _i1071.WinGameDialogApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i806.ICreateNewGameRepository>(
        () => _i723.CreateNewGameRepository(
              createGameSessionApi: gh<_i1070.CreateGameSessionApi>(),
              gameSessionApi: gh<_i820.GameSessionApi>(),
            ));
    gh.lazySingleton<_i535.IServerSessionsRepository>(
        () => _i101.ServerSessionsRepository(
              gh<_i303.ServerSessionsApi>(),
              gh<_i820.GameSessionApi>(),
            ));
    gh.lazySingleton<_i1032.IMainRepository>(() => _i1034.MainRepository(
          gh<_i811.MainApi>(),
          gh<_i742.UserApi>(),
        ));
    gh.factory<_i463.WinGameSessionDialogRepository>(() =>
        _i463.WinGameSessionDialogRepository(
            winGameDialogApi: gh<_i1071.WinGameDialogApi>()));
    gh.lazySingleton<_i212.IGameRepository>(
        () => _i122.GameRepository(gh<_i597.IWebsocketDataSource>()));
    gh.lazySingleton<_i311.IUserRepository>(
        () => _i649.UserRepository(gh<_i742.UserApi>()));
    gh.factory<_i709.IOnlineGameRepository>(() =>
        _i348.OnlineGameRepository(gameScreenApi: gh<_i605.GameScreenApi>()));
    gh.factory<_i579.WinGameDialogService>(() => _i579.WinGameDialogService(
        repository: gh<_i463.WinGameSessionDialogRepository>()));
    gh.lazySingleton<_i515.IGameListApiService>(() => _i91.GameListApiService(
          gh<_i535.IServerSessionsRepository>(),
          gh<_i311.IUserRepository>(),
          gh<_i212.IGameRepository>(),
        ));
    gh.lazySingleton<_i762.IGameScreenService>(() => _i327.GameScreenService(
          gh<_i311.IUserRepository>(),
          gh<_i212.IGameRepository>(),
          gh<_i709.IOnlineGameRepository>(),
        ));
    gh.lazySingleton<_i1007.ICreateNewGameService>(
        () => _i1055.CreateNewGameService(
              iCreateNewGameRepository: gh<_i806.ICreateNewGameRepository>(),
              iUserRepository: gh<_i311.IUserRepository>(),
            ));
    gh.lazySingleton<_i1006.IMainService>(() => _i808.MainService(
          gh<_i1032.IMainRepository>(),
          gh<_i311.IUserRepository>(),
          gh<_i212.IGameRepository>(),
        ));
    gh.lazySingleton<_i313.CreateNewGameController>(() =>
        _i313.CreateNewGameController(gh<_i1007.ICreateNewGameService>()));
    return this;
  }
}

class _$InjectorModule extends _i432.InjectorModule {}

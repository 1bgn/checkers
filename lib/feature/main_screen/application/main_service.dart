import 'package:checker/feature/main_screen/application/imain_service.dart';
import 'package:checker/feature/main_screen/data/repository/imain_repository.dart';
import 'package:checker/feature/main_screen/domain/model/main_user.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: IMainService)
class MainService implements IMainService{
  final IMainRepository _iMainRepository;

  MainService(this._iMainRepository);
  @override
  Future<MainUser> registerUser(RegisterUser registerUser) {
    return _iMainRepository.registerUser(registerUser);
  }

}
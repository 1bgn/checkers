 import 'package:checker/common/user_feature/data/repository/iuser_repository.dart';
import 'package:checker/feature/select_new_game/application/select_new_game_service.dart';
import 'package:checker/feature/select_new_game/presentation/ui/select_new_game_screen.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SelectNewGameService)
class ISelectNewGameService implements SelectNewGameService{
  final IUserRepository _iUserRepository;

  ISelectNewGameService(this._iUserRepository);

  @override
  bool getSound() {
    return _iUserRepository.getSound();
  }

  @override
  void setSound(bool sound) {
   _iUserRepository.setSound(sound);
  }

}
import 'package:checker/core/di/di_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;
const defaultEnv = Environment(
  "default",
);
const debugEnv = Environment(
  "debug",
);
// const mockEnv = Environment("mock");
@InjectableInit()
void initDi({Environment environment = defaultEnv}) {
  getIt.init(environment: environment.name);
}
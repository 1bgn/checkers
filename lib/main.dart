import 'package:checker/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:overlay_support/overlay_support.dart';

import 'core/di/di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  initDi();

  runApp(OverlaySupport.global(child: const MainWidget()));
}

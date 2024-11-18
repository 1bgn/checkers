import 'package:checker/main_widget.dart';
import 'package:flutter/material.dart';

import 'di/di_container.dart';
import 'feature/game_screen/presentation/ui/game_screen.dart';

void main() {
  initDi();

  runApp(const MainWidget());
}


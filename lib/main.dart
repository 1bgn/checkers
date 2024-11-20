import 'package:checker/main_widget.dart';
import 'package:flutter/material.dart';

import 'core/di/di_container.dart';
import 'feature/game_screen/presentation/ui/game_field_screen.dart';

void main() {
  initDi();

  runApp(const MainWidget());
}


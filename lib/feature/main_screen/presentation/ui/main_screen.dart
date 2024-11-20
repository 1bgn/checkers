import 'package:checker/feature/game_screen/presentation/controller/game_screen_controller.dart';
import 'package:checker/feature/game_screen/presentation/ui/state/game_screen_state.dart';
import 'package:checker/feature/main_screen/presentation/ui/register_user_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di_container.dart';
import 'widget/bottom_navigation_widget.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      showDialog(context: context, builder: (_)=>RegisterUserDialog(mainScreenController: context.read(),));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: widget.child
        // BlocProvider(
        //   create: (context) => GameScreenController(getIt()),
        //   child: BlocBuilder<GameScreenController,GameScreenState>(builder: (context, state) {
        //     return child;
        //   }),
        // ),
      ),
    );
  }
}

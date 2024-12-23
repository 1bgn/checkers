import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/di_container.dart';
import '../../controller/main_screen_controller.dart';
import '../../state/main_screen_state.dart';

class BottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenController(getIt()),
      child: BlocBuilder<MainScreenController  , MainScreenState>(
        builder: (context, state) {
          return NavigationBar(
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.add), label: 'Create new game'),
              NavigationDestination(icon: Icon(Icons.handshake), label: 'Open games'),
              NavigationDestination(
                  icon: Icon(Icons.security_rounded), label: 'Private games'),

            ],
            selectedIndex: state.pageIndex,
            onDestinationSelected: (value)=>_onItemSelected(context,value),
          );
        },
      ),
    );
  }

  void _onItemSelected(BuildContext context,int index) {
    context.read<MainScreenController>().setPageIndex(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go("/");
        break;
      case 1:
        GoRouter.of(context).go("/open-game-list-route");
      case 2:
        GoRouter.of(context).go("/private-game-list-route");
        break;
      default:
        throw Exception("No item found");
    }
  }
}

import 'package:checker/common/user_feature/domain/model/get_user.dart';
import 'package:checker/feature/main_screen/presentation/controller/main_screen_controller.dart';
import 'package:checker/feature/main_screen/presentation/ui/register_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        .addPostFrameCallback((_) async {
          final controller = context.read<MainScreenController>();
          final localUser = controller.getLocalUser();
          if(localUser!=null){
            final remoteUser = await controller.getRemoteUser(GetUser(nickname: localUser.nickname));
            if(remoteUser==null){
              showDialog(context: context,barrierDismissible: false, builder: (_)=>RegisterUserDialog(mainScreenController: controller,));
            }else{
              controller.saveLocalUser(remoteUser);
            }
          }else{
              showDialog(context: context,barrierDismissible: false, builder: (_)=>RegisterUserDialog(mainScreenController: controller,));
          }

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

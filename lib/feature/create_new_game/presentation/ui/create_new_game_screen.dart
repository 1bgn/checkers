import 'package:checker/core/routing/go_router_provider.dart';
import 'package:checker/feature/create_new_game/presentation/controller/create_new_game_controller.dart';
import 'package:checker/feature/create_new_game/presentation/controller/create_new_game_controller.dart';
import 'package:checker/feature/create_new_game/presentation/ui/state/create_new_game_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class CreateNewGameScreen extends StatefulWidget {
  @override
  State<CreateNewGameScreen> createState() => _CreateNewGameScreenState();
}

class _CreateNewGameScreenState extends State<CreateNewGameScreen> {
  final passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();

    passwordController.addListener((){
      final controller = context.read<CreateNewGameController>();
      controller.setPassword(passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewGameController, CreateNewGameState>(
      builder: (context, state) {
        final controller = context.read<CreateNewGameController>();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Создание новой игры"),
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: state.isPrivate,
                        onChanged: (v) {
                          setState(() {
                            controller.setPrivate(v ?? false);
                          });
                        }),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(child: Text("Приватная игра")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      enabled: state.isPrivate,
                      decoration: InputDecoration(hintText: "Код"),
                      maxLength: 4,
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CupertinoButton(
                          child: Text("Создать"), onPressed: () async {
                          final result =  await controller.createNewGame();
                          final connection = await controller.connectToGame();
                           context.pushReplacement("/online-game-route",extra:[result,connection] );
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

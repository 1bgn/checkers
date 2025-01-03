import 'package:checker/feature/select_new_game/presentation/controller/select_new_game_screen_controller.dart';
import 'package:checker/feature/select_new_game/presentation/state/select_new_game_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class SelectNewGameScreen extends StatefulWidget {
  const SelectNewGameScreen({super.key});

  @override
  State<SelectNewGameScreen> createState() => _SelectNewGameScreenState();
}

class _SelectNewGameScreenState extends State<SelectNewGameScreen> {

  @override
  void initState() {
    final controller = context.read<SelectNewGameScreenController>();
    controller.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SelectNewGameScreenController , SelectNewGameScreenState>(
        builder: (context, state) {
          final controller = context.read<SelectNewGameScreenController>();
          return Stack(

            children: [
              Align(alignment: Alignment.topRight,child:state.enableSound? InkWell(onTap: (){
                controller.setSound(false);
              },child: Icon(Icons.music_note)):InkWell(onTap: (){
                controller.setSound(true);

              },child: Icon(Icons.music_off)),),
              Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FilledButton(

                              onPressed: () {
                                context.push("/game-route");
                              },
                              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                              child: Text(
                                "Одиночная игра",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FilledButton(
                              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),

                              onPressed: () {
                                context.push("/create-game-route");
                              },
                              child: Text(
                                "Сетевая игра",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),

                            // MaterialButton(
                            //   onPressed: () {
                            //     context.push("/create-game-route");
                            //   },
                            //   child: Text("Connect open game",style: TextStyle(fontSize: 20),),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     SizedBox(
                  //       child: Shimmer.fromColors(
                  //         baseColor: Colors.black,
                  //         highlightColor: Colors.grey,
                  //         child: Text(
                  //           'Made by Khrispens',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             fontSize: 14.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

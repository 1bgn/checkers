import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class SelectNewGameScreen extends StatelessWidget {
  const SelectNewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                      child: Text(
                        "Одиночная игра",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FilledButton(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.grey,
                  child: Text(
                    'Khrispens',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

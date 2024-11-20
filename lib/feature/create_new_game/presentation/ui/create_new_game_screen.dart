import 'package:checker/core/routing/go_router_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class CreateNewGameScreen extends StatefulWidget {
  @override
  State<CreateNewGameScreen> createState() => _CreateNewGameScreenState();
}

class _CreateNewGameScreenState extends State<CreateNewGameScreen> {
  bool isPrivate = false;

  @override
  Widget build(BuildContext context) {
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
                Checkbox(value: isPrivate, onChanged: (v) {
                  setState(() {
                    isPrivate = v??false;
                  });
                }),
                SizedBox(
                  width: 12,
                ),
                Expanded(child: Text("Приватная игра")),
              ],
            ),
            Row(children: [
              Expanded(child: TextFormField(enabled: isPrivate,decoration: InputDecoration(hintText: "Код"),maxLength: 4,))
            ],),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [Expanded(
              child: CupertinoButton(child: Text("Создать"), onPressed: (){
              
              }),
            )],)
          ],
        ),
      ),
    );
  }
}

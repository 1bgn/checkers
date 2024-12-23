import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/win_game_dialog/presentation/controller/win_game_dialog_controller.dart';
import 'package:checker/feature/win_game_dialog/presentation/state/win_game_dialog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinGameDialog extends StatefulWidget {
  final GameSession gameSession;

  const WinGameDialog({super.key, required this.gameSession});

  @override
  State<WinGameDialog> createState() => _WinGameDialogState();
}

class _WinGameDialogState extends State<WinGameDialog> {
  @override
  void initState() {
    final controller = context.read<WinGameDialogController>();
    controller.init(widget.gameSession);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WinGameDialogController, WinGameDialogState>(
  builder: (context, state) {
    final controller = context.read<WinGameDialogController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24,),
        Row(
          children: [
            Expanded(
              child: Text(
                "Победила ${widget.gameSession.gameSessionItem.winner == widget.gameSession.gameSessionItem.whiteGamePlayer ? "белая" : "черная"} сторона",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(color: Colors.brown,onPressed: (){
              controller.resetGame();
            },child: Text("Повторить",style: TextStyle(fontSize: 16,color: Colors.white),),),
            SizedBox(width: 8,),
            MaterialButton(color: Colors.redAccent,onPressed: (){
              controller.finishGame();
            },child: Text("Завершить игру",style: TextStyle(fontSize: 16,color: Colors.white),),),
          ],
        ),
        SizedBox(height: 24,),

      ],
    );
  },
);
  }
}

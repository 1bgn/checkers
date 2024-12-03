import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/get_session.dart';
import 'package:checker/feature/server_sessions_screeen/presentation/controller/game_session_controller.dart';
import 'package:checker/feature/server_sessions_screeen/presentation/state/game_sessions_state.dart';
import 'package:checker/feature/server_sessions_screeen/presentation/widget/game_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GameSessionsScreen extends StatefulWidget {
  final bool isPrivate;

  const GameSessionsScreen({super.key, required this.isPrivate});

  @override
  State<GameSessionsScreen> createState() => _GameSessionsScreenState();
}

class _GameSessionsScreenState extends State<GameSessionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GameSessionController>().initGameSessions(widget.isPrivate);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameSessionController, GameSessionsState>(
      builder: (context, state,) {
        final controller = context.read<GameSessionController>();

        return Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Expanded(
                child: ListView(children: state.sessions.map((e)=>GestureDetector(onTap: () async {
                  if(e.isPrivate){
                    showDialog(context: context, builder: (context)=>Dialog(child: Text("Не сделано."),));
                  }else{
                    final result = await controller.getSession(GetSession(sessionId: e.sessionId));
                    final connection = await controller.connectToGame(e);
                    context.push("/online-game-route",extra:[result,connection] );
                  }
                },child: GameListItem(item: e,))).toList(),),
              ),
            ],
          ),
        );
      },
    );
  }
}
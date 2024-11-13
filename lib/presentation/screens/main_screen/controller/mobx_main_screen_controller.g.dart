// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_main_screen_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxMainScreenController on _MobxMainScreenController, Store {
  late final _$_gameFieldAtom =
      Atom(name: '_MobxMainScreenController._gameField', context: context);

  @override
  GameField? get _gameField {
    _$_gameFieldAtom.reportRead();
    return super._gameField;
  }

  @override
  set _gameField(GameField? value) {
    _$_gameFieldAtom.reportWrite(value, super._gameField, () {
      super._gameField = value;
    });
  }

  late final _$timeCounterAtom =
      Atom(name: '_MobxMainScreenController.timeCounter', context: context);

  @override
  int get timeCounter {
    _$timeCounterAtom.reportRead();
    return super.timeCounter;
  }

  @override
  set timeCounter(int value) {
    _$timeCounterAtom.reportWrite(value, super.timeCounter, () {
      super.timeCounter = value;
    });
  }

  late final _$winnerAtom =
      Atom(name: '_MobxMainScreenController.winner', context: context);

  @override
  Color? get winner {
    _$winnerAtom.reportRead();
    return super.winner;
  }

  @override
  set winner(Color? value) {
    _$winnerAtom.reportWrite(value, super.winner, () {
      super.winner = value;
    });
  }

  late final _$gameOverAsyncAction =
      AsyncAction('_MobxMainScreenController.gameOver', context: context);

  @override
  Future<void> gameOver(Color winner) {
    return _$gameOverAsyncAction.run(() => super.gameOver(winner));
  }

  @override
  String toString() {
    return '''
timeCounter: ${timeCounter},
winner: ${winner}
    ''';
  }
}

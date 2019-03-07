import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_flood_fill/models/game_model.dart';
import 'screens/game_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: GameModel(10),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScopedModelDescendant<GameModel>(
          builder: (context, child, model) {
            return GameScreen(
              model.gameGrid,
              model.currentTurn,
              model.availableColors,
              model.updateColorGrid,
              model.restartGame,
              model.gameStatus,
            );
          },
        ),
      ),
    );
  }
}

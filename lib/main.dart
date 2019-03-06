import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'game_model.dart';
import 'widgets/color_palette.dart';

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
            return ColorGame(model.gameGrid, model.currentTurn);
          },
        ),
      ),
    );
  }
}

class GameState extends ValueNotifier<Color> {
  GameState(value) : super(value);
}

class GridItem extends StatelessWidget {
  final Color color;

  GridItem(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      width: 25.0,
      color: color,
    );
  }
}

class ColorGame extends StatelessWidget {
  final int _currentTurn;
  final List<List<Color>> _gameGrid;

  ColorGame(this._gameGrid, this._currentTurn);

  _buildColorGridRowItem(Color color) {
    return GridItem(color);
  }

  _buildColorGridRow() {
    List<Widget> grid = List.generate(_gameGrid.length, (i) {
      List<Widget> rowItems = List.generate(
          _gameGrid[i].length, (j) => _buildColorGridRowItem(_gameGrid[i][j]));

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: rowItems,
      );
    });

    return grid;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = _buildColorGridRow();

    return Scaffold(
      appBar: AppBar(
        title: Text("Turns: $_currentTurn"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          ),
        ),
      ),
      bottomNavigationBar: ScopedModelDescendant<GameModel>(
          builder: (context, child, model) =>
              ColorPalette(model.availableColors, model.updateColorGrid)),
    );
  }
}

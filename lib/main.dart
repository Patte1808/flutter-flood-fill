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
            return ColorGame(model.gameGrid, model.currentTurn, model.availableColors, model.updateColorGrid, model.restartGame);
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
  final List<Color> _availableColors;
  final Function _updateColorGrid;
  final Function _restartGame;

  ColorGame(this._gameGrid, this._currentTurn, this._availableColors,
      this._updateColorGrid, this._restartGame);

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () => this._restartGame(),
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          ),
        ),
      ),
      bottomNavigationBar: ColorPalette(this._availableColors, this._updateColorGrid),
    );
  }
}

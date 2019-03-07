import 'package:flutter/material.dart';
import '../widgets/color_palette.dart';
import '../models/color_tile.dart';
import '../widgets/grid_item.dart';
import '../models/game_model.dart';

class GameScreen extends StatelessWidget {
  final int _currentTurn;
  final List<List<ColorTile>> _gameGrid;
  final List<Color> _availableColors;
  final Function _updateColorGrid;
  final Function _restartGame;
  final GameStatus _gameStatus;

  GameScreen(this._gameGrid, this._currentTurn, this._availableColors,
      this._updateColorGrid, this._restartGame, this._gameStatus);

  _buildColorGridRowItem(Color color) {
    return GridItem(color);
  }

  _buildColorGridRow() {
    List<Widget> grid = List.generate(_gameGrid.length, (i) {
      List<Widget> rowItems = List.generate(
          _gameGrid[i].length, (j) => _buildColorGridRowItem(_gameGrid[i][j].color));

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

    if (this._gameStatus == GameStatus.finished) {
      // Do something
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Turns: ${this._currentTurn}"),
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
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'color_tile.dart';

enum GameStatus { active, pause, finished }

class GameModel extends Model {
  List<List<ColorTile>> _gameGrid;

  List<List<ColorTile>> get gameGrid => _gameGrid;

  List<Color> _availableColors = [
    Colors.blueAccent,
    Colors.deepOrangeAccent,
    Colors.cyanAccent,
    Colors.purpleAccent,
    Colors.greenAccent,
  ];

  List<Color> get availableColors => _availableColors;

  int _maxTurns;

  int get maxTurns => _maxTurns;

  int _currentTurn = 0;

  int get currentTurn => _currentTurn;

  GameStatus _gameStatus = GameStatus.active;
  GameStatus get gameStatus => _gameStatus;

  Color _getRandomColor() {
    final random = Random();

    return availableColors[random.nextInt(availableColors.length)];
  }

  buildColorGrid(int gridSize) {
    _generateGameGrid(gridSize);

    notifyListeners();
  }

  updateColorGrid(Color newColor) {
    _floodFill(null, newColor, 0, 0);

    _currentTurn++;

    notifyListeners();
  }

  restartGame() {
    _generateGameGrid(10);
    _currentTurn = 0;

    notifyListeners();
  }

  _floodFill(Color prevColor, Color newColor, int x, int y) {
    if (y < 0 ||
        x < 0 ||
        this._gameGrid.length <= x ||
        this._gameGrid[x].length <= y) return;

    if (prevColor == null) prevColor = this._gameGrid[x][y].color;

    Color oldColor = this._gameGrid[x][y].color;

    if (oldColor == newColor || this._gameGrid[x][y].color != prevColor) return;

    this._gameGrid[x][y].color = newColor;

    _checkForWinningCondition();

    _floodFill(prevColor, newColor, x + 1, y);
    _floodFill(prevColor, newColor, x, y + 1);
    _floodFill(prevColor, newColor, x - 1, y);
    _floodFill(prevColor, newColor, x, y - 1);
  }

  _checkForWinningCondition() {
    var flattenList = this._gameGrid.expand((i) => i).toList();

    if (flattenList.where((colorTile) => this._gameGrid[0][0].color != colorTile.color).length == 0) {
      this._gameStatus = GameStatus.finished;

      notifyListeners();
    }
  }

  _generateGameGrid(int gridSize) {
    _gameGrid = List<List<ColorTile>>.generate(
      gridSize,
      (y) => List.generate(
            gridSize,
            (x) => ColorTile(
                  _getRandomColor(),
                ),
          ),
    );
  }

  GameModel(int gridSize) {
    buildColorGrid(gridSize);
  }
}

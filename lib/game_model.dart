import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GameModel extends Model {

  List<List<Color>> _gameGrid;
  List<List<Color>> get gameGrid => _gameGrid;

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

  _floodFill(prevColor, newColor, x, y) {
    if (y < 0 || x < 0 || this._gameGrid.length <= x || this._gameGrid[x].length <= y)
      return;

    if (prevColor == null)
      prevColor = this._gameGrid[x][y];

    Color oldColor = this._gameGrid[x][y];

    if (oldColor == newColor || this._gameGrid[x][y] != prevColor)
      return;

    this._gameGrid[x][y] = newColor;

    _floodFill(prevColor, newColor, x + 1, y);
    _floodFill(prevColor, newColor, x, y + 1);
    _floodFill(prevColor, newColor, x - 1, y);
    _floodFill(prevColor, newColor, x, y - 1);
  }

  _generateGameGrid(int gridSize) {
    _gameGrid = List<List<Color>>.generate(
    gridSize, (y) => List.generate(gridSize, (x) => _getRandomColor()));
  }

  GameModel(int gridSize) {
    buildColorGrid(gridSize);
  }
}

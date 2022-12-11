import 'package:flutter/material.dart';
import 'dart:math';

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class Utils {
  static Color randomColorGenerate() {
    int r, g, b;
    r = Random().nextInt(256);
    g = Random().nextInt(256);
    b = Random().nextInt(256);

    return Color.fromRGBO(r, g, b, 100);
  }
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles = [
    StatelessColorfulTile(),
    StatelessColorfulTile(),
    StatelessColorfulTile(),
  ];

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        margin : const EdgeInsets.fromLTRB(50, 300, 0, 0),
        child : Row(
        
          children : tiles,
        ),
      ),
      floatingActionButton : FloatingActionButton(
        onPressed : swapTiles,
        child : const Icon(Icons.sentiment_very_satisfied)
      ),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(0, tiles.removeAt(tiles.length - 1));
    });
  }
}

class StatelessColorfulTile extends StatelessWidget {

  Color myColor = Utils.randomColorGenerate();

  @override
  Widget build(BuildContext context) {
    return Container( 
      color : myColor,
      child : const Padding(
        padding : EdgeInsets.all(50)
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'squareSwap.dart' as fun;

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles = [
    StatefulColorfulTile(key : UniqueKey()),
    StatefulColorfulTile(key : UniqueKey()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Row(
        children : tiles,
      ),
      floatingActionButton : FloatingActionButton(
        onPressed : swapTiles,
        child : const Icon(Icons.sentiment_very_satisfied)
      ),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatefulColorfulTile extends StatefulWidget {
  StatefulColorfulTile ({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() => ColorfulTileState();
}

class ColorfulTileState extends State<StatefulColorfulTile> {
  Color myColor = const Color.fromRGBO(0, 0, 0, 0);

  void initState() {
    super.initState();
    myColor = fun.Utils.randomColorGenerate();
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      color : myColor,
      child : const Padding(
        padding : EdgeInsets.all(70.0),
      )
    );
  }
}
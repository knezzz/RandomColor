import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Color> generatedColors = <Color>[];
  ColorHue _hueType = ColorHue.random;
  ColorBrightness _colorLuminosity = ColorBrightness.random;
  ColorSaturation _colorSaturation = ColorSaturation.random;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Example of Random colors library'),
      ),
      body: Container(
        child: _showColors()
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: new FloatingActionButton(
              tooltip: 'RefreshColors',
              child: const Icon(Icons.refresh),
              onPressed: _updateColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: new FloatingActionButton(
              tooltip: 'Filter',
              child: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showColors() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index){
        Color _color;

        if(generatedColors.length > index){
          _color = generatedColors[index];
        }else{
          _color = RandomColor().randomColor(
            colorHue: _hueType,
            colorSaturation: _colorSaturation,
            colorBrightness: _colorLuminosity
          );

          generatedColors.add(_color);
        }

        Color getTextColor() {
          if (_color == null) {
            return Colors.black;
          }

          if (_color.computeLuminance() > 0.3) {
            return Colors.black;
          } else {
            return Colors.white;
          }
        }

        return Card(
          color: _color,
          child: Container(
            margin: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(getColorNameFromColor(_color).getName,
                    style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 13.0,
                      color: getTextColor()
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text('#${_color.value.toRadixString(16).toUpperCase()}',
                    style: Theme.of(context).textTheme.caption.copyWith(
                      color: getTextColor(),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          title: Text('Hello!'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Text('Color hue: '),
                  ),

                  DropdownButton<int>(
                    value: _hueType.type,
                    onChanged: (int hueType){
                      setState(() => _hueType = ColorHue.values[hueType]);

                      Navigator.of(context).pop();
                      _updateColor();
                    },
                    items: ColorHue.values.map((ColorHue cf) => DropdownMenuItem<int>(
                      child: Container(
                        child: Text(cf.toString())
                      ),
                      value: cf.type)
                    ).toList(),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Text('Color brightness: '),
                  ),

                  DropdownButton<int>(
                    value: _colorLuminosity.type,
                    onChanged: (int luminosity){
                      setState(() => _colorLuminosity = ColorBrightness.values[luminosity]);

                      Navigator.of(context).pop();
                      _updateColor();
                    },
                    items: ColorBrightness.values.map((ColorBrightness l) => DropdownMenuItem<int>(
                      child: Container(
                        child: Text(l.toString())
                      ),
                      value: l.type)
                    ).toList(),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Text('Color saturation: '),
                  ),

                  DropdownButton<int>(
                    value: _colorSaturation.type,
                    onChanged: (int saturation){
                      setState(() => _colorSaturation = ColorSaturation.values[saturation]);

                      Navigator.of(context).pop();
                      _updateColor();
                    },
                    items: ColorSaturation.values.map((ColorSaturation cf) => DropdownMenuItem<int>(
                      child: Container(
                        child: Text(cf.toString())
                      ),
                      value: cf.type)
                    ).toList(),
                  )
                ],
              ),
            ),
          ]
        );
      }
    ).catchError(print);
  }

  void _updateColor(){
    setState(() {
      generatedColors.clear();
    });
  }
}

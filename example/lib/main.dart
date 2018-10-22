import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Color> generatedColors = <Color>[];
  final List<ColorHue> _hueType = <ColorHue>[
    ColorHue.green,
    ColorHue.red,
    ColorHue.pink,
    ColorHue.purple,
    ColorHue.blue,
    ColorHue.yellow,
    ColorHue.orange
  ];
  ColorBrightness _colorLuminosity = ColorBrightness.random;
  ColorSaturation _colorSaturation = ColorSaturation.random;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Example of Random colors library'),
      ),
      body: Container(child: _showColors()),
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
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Color _color;

        if (generatedColors.length > index) {
          _color = generatedColors[index];
        } else {
          _color = RandomColor().randomColor(
              colorHue: ColorHue.multiple(colorHues: _hueType),
              colorSaturation: _colorSaturation,
              colorBrightness: _colorLuminosity);

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
                  child: Text(
                    getColorNameFromColor(_color).getName,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 13.0, color: getTextColor()),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '#${_color.value.toRadixString(16).toUpperCase()}',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: getTextColor(),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFilterDialog() async {
    await showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return FilterDialog(
            hueType: _hueType,
            colorLuminosity: _colorLuminosity,
            colorSaturation: _colorSaturation,
            hueTypeChange: (List<ColorHue> hues) {
              _hueType.clear();
              _hueType.addAll(hues);
            },
            luminosityTypeChange: (ColorBrightness cb) => _colorLuminosity = cb,
            saturationTypeChange: (ColorSaturation cs) => _colorSaturation = cs,
          );
        }).catchError(print);

    _updateColor();
  }

  void _updateColor() {
    setState(() {
      generatedColors.clear();
    });
  }
}

typedef void HueTypeChange(List<ColorHue> colorHues);
typedef void SaturationTypeChange(ColorSaturation colorSaturation);
typedef void LuminosityTypeChange(ColorBrightness colorBrightness);

class FilterDialog extends StatefulWidget {
  FilterDialog({
    Key key,
    this.hueType,
    this.colorSaturation,
    this.colorLuminosity,
    this.hueTypeChange,
    this.saturationTypeChange,
    this.luminosityTypeChange,
  }) : super(key: key);

  final List<ColorHue> hueType;
  final ColorBrightness colorLuminosity;
  final ColorSaturation colorSaturation;

  final HueTypeChange hueTypeChange;
  final SaturationTypeChange saturationTypeChange;
  final LuminosityTypeChange luminosityTypeChange;

  @override
  _FilterDialogState createState() => new _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final List<ColorHue> _hueType = <ColorHue>[];
  ColorBrightness _colorLuminosity;
  ColorSaturation _colorSaturation;

  @override
  void initState() {
    super.initState();

    _hueType.addAll(widget.hueType);
    _colorLuminosity = widget.colorLuminosity;
    _colorSaturation = widget.colorSaturation;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Text('Color hue: '),
            ),
            Container(
              height: 175.0,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: ColorHue.values.length,
                itemBuilder: (BuildContext context, int index) {
                  final ColorHue _hue = _hueType.firstWhere(
                      (ColorHue hue) => hue.type == ColorHue.values[index].type,
                      orElse: () => null);
                  final Color _color = RandomColor(8).randomColor(
                      colorHue: ColorHue.values[index],
                      colorSaturation: _colorSaturation,
                      colorBrightness: _colorLuminosity);

                  return Container(
                    height: 50.0,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 12.0,
                          color: _color,
                        ),
                        Expanded(
                          child: Container(
                            color: _color.withOpacity(0.1),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(ColorHue.values[index].toString()),
                                Checkbox(
                                  value: _hue != null,
                                  onChanged: (bool value) {
                                    if (_hue != null) {
                                      _removeColorHue(_hue);
                                    } else {
                                      _addColorHue(ColorHue.values[index]);
                                    }

                                    _hueType.removeWhere(
                                        (ColorHue hue) => hue == null);
                                    widget.hueTypeChange(_hueType);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
              onChanged: (int luminosity) {
                setState(() =>
                    _colorLuminosity = ColorBrightness.values[luminosity]);

                widget.luminosityTypeChange(_colorLuminosity);
              },
              items: ColorBrightness.values
                  .map((ColorBrightness l) => DropdownMenuItem<int>(
                      child: Container(child: Text(l.toString())),
                      value: l.type))
                  .toList(),
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
              onChanged: (int saturation) {
                setState(() =>
                    _colorSaturation = ColorSaturation.values[saturation]);

                widget.saturationTypeChange(_colorSaturation);
              },
              items: ColorSaturation.values
                  .map((ColorSaturation cf) => DropdownMenuItem<int>(
                      child: Container(child: Text(cf.toString())),
                      value: cf.type))
                  .toList(),
            )
          ],
        ),
      ),
    ]);
  }

  void _addColorHue(ColorHue c) {
    setState(() {
      _hueType.add(c);
    });
  }

  void _removeColorHue(ColorHue c) {
    setState(() {
      _hueType.remove(c);

      if (_hueType.isEmpty) {
        _hueType.add(ColorHue.random);
      }
    });
  }
}

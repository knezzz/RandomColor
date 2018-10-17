///
/// Class for creating custom colors
/// This is a port of: https://github.com/lzyzsd/AndroidRandomColor to dart
///
/// Some things are changed/added to better fit in the game
///

part of random_color;

///
/// Generate random colors that are visually appealing
///
class RandomColor {
  bool debug = false;

  final int minBrightness = 16;
  final int maxBrightness = 84;
  final double _defaultColorChangeRatio = 20.0;
  Random _random;
  CurrentColor _currentColor;

  /// Accepts seed for random generator as a parameter
  RandomColor([int seed]) {
    if (seed != null) {
      print('Seed for random color: $seed');
      _random = new Random(seed);
    }

    _random ??= new Random();
  }

  Color get getCurrentColor => _currentColor.currentColor;
  int get getCurrentColorBrightness => _currentColor.brightness;
  int get getCurrentColorHue => _currentColor.hue;

  int get getCurrentColorSaturation => _currentColor.saturation;

  Color get getDarkerCurrentColor => _changeCurrentColor(brighter: false);
  Color get getLighterCurrentColor => _changeCurrentColor(brighter: true);

  double get _getColorBrightnessChangeRatio =>
      ((100 - _currentColor.brightness) / 100) * (_defaultColorChangeRatio * 0.4) + (_defaultColorChangeRatio * 1.4);

  double get _getColorSaturationChangeRatio =>
      ((100 - _currentColor.saturation) / 100) * (_defaultColorChangeRatio * 0.4) + (_defaultColorChangeRatio * 0.6);
  Color changeCurrentColor() {
    if (_currentColor == null) {
      return null;
    }

    /// Dark colors have more chance to became darker and light colors
    /// have more chance to became lighter
    final double colorChange = _random.nextDouble() + ((_currentColor.brightness / maxBrightness) * 2);
    print('Color change : $colorChange');
    if (colorChange < 1.5) {
      print('Returning darker color!');
      return getDarkerCurrentColor;
    }

    print('Returning lighter color!');
    return getLighterCurrentColor;
  }

  /// Get color for text so its visible on current color
  Color getCurrentTextColor() {
    if (_currentColor == null) {
      return Colors.black;
    }

    if (_currentColor.brightness > 80) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  ///
  /// Get random color
  ///
  /// Optional arguments:
  /// [hueType] - get wanted color range
  /// [value] - get specific hue level colors
  /// [saturationType] - get specific saturation type colors
  /// [brightnessType] - get specific brightness colors
  ///
  Color randomColor(
      {ColorHue colorHue,
      ColorSaturation colorSaturation,
      ColorBrightness colorBrightness,
      bool debug = true,
      }){

    colorHue ??= ColorHue.random;
    colorSaturation ??= ColorSaturation.random;
    colorBrightness ??= ColorBrightness.random;

    this.debug = debug;

    int s;
    int h;
    int b;

    h = colorHue.returnHue(_random);
    s = colorSaturation.returnSaturation(_random);
    b = colorBrightness.returnBrightness(_random);

    _log('Color hue: $h');
    _log('Color saturation: $s');
    _log('Color brightness: $b');

    return _getColor(h, s, b);
  }

  Color _changeCurrentColor({bool brighter = true}){
    final double _colorBrightnessChangeRatio = _getColorBrightnessChangeRatio;

    int brightness;

    if(brighter){
      brightness =
        min((_currentColor.brightness + (_colorBrightnessChangeRatio / _defaultColorChangeRatio)).floor(), 100);
    }else{
      brightness =
        max((_currentColor.brightness - (_colorBrightnessChangeRatio / _defaultColorChangeRatio)).floor(), 0);
    }

    final int saturation = _changeSaturation();

    _log('Color info :: Original color saturation: ${_currentColor.saturation} '
      'Original color brightness: ${_currentColor.brightness}');
    _log('Color info :: Color change brightness ratio: $_colorBrightnessChangeRatio '
      'Saturation: $saturation Brightness: $brightness');

    return _getColor(_currentColor.hue, saturation, brightness);
  }

  int _changeSaturation() {
    final double _colorSaturationChangeRatio = _getColorSaturationChangeRatio;

    int saturation;

    if (_random.nextBool()) {
      saturation =
          min((_currentColor.saturation + (_colorSaturationChangeRatio / _defaultColorChangeRatio)).floor(), 100);
    } else {
      saturation =
          max((_currentColor.saturation - (_colorSaturationChangeRatio / _defaultColorChangeRatio)).floor(), 0);
    }

    _log('Color change saturation ratio: $_colorSaturationChangeRatio');

    return saturation;
  }

  /// Need to get RGB from hsv values and make new color from them.
  /// Ported to dart from: https://stackoverflow.com/a/25964657/3700909
  Color _getColor(int hue, int saturation, int brightness) {
    final double s = saturation / 100;
    final double v = brightness / 100;

    final Color _color = HSLColor.fromAHSL(1.0, hue.toDouble(), s, v).toColor();
    _currentColor = CurrentColor(_color, hue, saturation, brightness);

    return _color;
  }

  void _log(String s) {
    if (debug) {
      print('Random color: $s');
    }
  }
}
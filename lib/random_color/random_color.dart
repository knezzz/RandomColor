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
  /// Accepts seed for random generator as a parameter
  RandomColor([int seed]) {
    if (seed != null) {
      print('Seed for random color: $seed');
      _random = new Random(seed);
    }

    _random ??= new Random();
  }

  bool debug = false;

  final int minBrightness = 16;
  final int maxBrightness = 84;
  Random _random;

  ///
  /// Get random color
  ///
  /// Optional arguments:
  /// [hueType] - get wanted color range
  /// [value] - get specific hue level colors
  /// [saturationType] - get specific saturation type colors
  /// [brightnessType] - get specific brightness colors
  ///
  Color randomColor({
    ColorHue colorHue,
    ColorSaturation colorSaturation,
    ColorBrightness colorBrightness,
    bool debug = true,
  }) {
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

  /// Need to get RGB from hsv values and make new color from them.
  /// Ported to dart from: https://stackoverflow.com/a/25964657/3700909
  Color _getColor(int hue, int saturation, int brightness) {
    final double s = saturation / 100;
    final double v = brightness / 100;

    final Color _color = HSLColor.fromAHSL(1.0, hue.toDouble(), s, v).toColor();

    return _color;
  }

  void _log(String s) {
    if (debug) {
      print('Random color: $s');
    }
  }
}

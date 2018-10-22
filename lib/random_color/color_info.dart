part of random_color;

class ColorBrightness {
  static const int minBrightness = 16;
  static const int maxBrightness = 84;

  static ColorBrightness get dark =>
      ColorBrightness._(Range(minBrightness, minBrightness + 30), 3);
  static ColorBrightness get light => ColorBrightness._(
      Range(((maxBrightness + minBrightness) / 2).round(), maxBrightness), 1);

  static ColorBrightness get primary =>
      ColorBrightness._(Range(minBrightness + 20, maxBrightness - 20), 2);
  static ColorBrightness get random =>
      ColorBrightness._(Range(minBrightness, maxBrightness), 5);

  static List<ColorBrightness> get values =>
      <ColorBrightness>[veryLight, light, primary, dark, veryDark, random];
  static ColorBrightness get veryDark =>
      ColorBrightness._(Range(minBrightness ~/ 2, minBrightness + 30), 4);
  static ColorBrightness get veryLight => ColorBrightness._(
      Range(((maxBrightness + minBrightness) / 2).round(),
          maxBrightness + (minBrightness ~/ 2)),
      0);
  final Range _brightness;
  final int type;
  const ColorBrightness.custom(Range brightnessRange)
      : _brightness = brightnessRange,
        type = -1;

  const ColorBrightness._(this._brightness, this.type);

  int returnBrightness(Random random) {
    return _brightness.randomWithin(random);
  }

  @override
  String toString() {
    switch (type) {
      case 0:
        return 'very light';
      case 1:
        return 'light';
      case 2:
        return 'primary';
      case 3:
        return 'dark';
      case 4:
        return 'very dark';
      case 5:
        return 'random';
    }

    return 'custom';
  }
}

class ColorHue {
  static ColorHue get blue => ColorHue._(Range(180, 240), 4);

  static ColorHue get green => ColorHue._(Range(60, 180), 3);

  static ColorHue get orange => ColorHue._(Range(10, 40), 1);

  static ColorHue get pink => ColorHue._(Range(315, 355), 6);
  static ColorHue get purple => ColorHue._(Range(240, 315), 5);

  static ColorHue get random => ColorHue._(Range(0, 360), 7);
  static ColorHue get red => ColorHue._(Range(-5, 10), 0);
  static List<ColorHue> get values =>
      <ColorHue>[red, orange, yellow, green, blue, purple, pink, random];
  static ColorHue get yellow => ColorHue._(Range(40, 60), 2);
  final Range _hue;
  final int type;
  const ColorHue.custom(Range hueRange)
      : _hue = hueRange,
        type = -1;
  const ColorHue._(this._hue, this.type);

  int returnHue(Random random) {
    int _h = _hue.randomWithin(random);

    if (_h < 0) {
      _h = 360 + _h;
    }

    return _h;
  }

  @override
  String toString() {
    switch (type) {
      case 0:
        return 'red';
      case 1:
        return 'orange';
      case 2:
        return 'yellow';
      case 3:
        return 'green';
      case 4:
        return 'blue';
      case 5:
        return 'purple';
      case 6:
        return 'pink';
      case 7:
        return 'random';
    }

    return 'custom';
  }

  static ColorHue multiple(
      {@required List<ColorHue> colorHues, Random random}) {
    colorHues.shuffle(random);
    return colorHues.first;
  }
}

class ColorSaturation {
  static ColorSaturation get highSaturation =>
      ColorSaturation._(Range(80, 100), 2);

  static ColorSaturation get lowSaturation =>
      ColorSaturation._(Range(0, 40), 0);

  static ColorSaturation get mediumSaturation =>
      ColorSaturation._(Range(40, 80), 1);
  static ColorSaturation get monochrome => ColorSaturation._(Range.zero(), 4);

  static ColorSaturation get random => ColorSaturation._(Range(20, 100), 3);
  static List<ColorSaturation> get values => <ColorSaturation>[
        lowSaturation,
        mediumSaturation,
        highSaturation,
        random,
        monochrome
      ];
  final Range _saturation;
  final int type;
  const ColorSaturation.custom(Range saturationRange)
      : _saturation = saturationRange,
        type = -1;

  const ColorSaturation._(this._saturation, this.type);

  int returnSaturation(Random random) {
    return _saturation.randomWithin(random);
  }

  @override
  String toString() {
    switch (type) {
      case 0:
        return 'low saturation';
      case 1:
        return 'medium saturation';
      case 2:
        return 'high saturation';
      case 3:
        return 'random';
      case 4:
        return 'monochrome';
    }

    return 'custom';
  }
}

class Range {
  int start;

  int end;

  Range(this.start, this.end);

  Range.staticValue(int value)
      : start = value,
        end = value;
  Range.zero()
      : start = 0,
        end = 0;

  Range operator +(Range range) {
    start = (start + range.start) ~/ 2;

    return this;
  }

  bool contain(int value) {
    return value >= start && value <= end;
  }

  int randomWithin(Random random) {
    return (start + random.nextDouble() * (end - start)).round();
  }
}

# Random color generator

This library will generate random colors that are visually pleasing and can be customized by passing custom hue, saturation and brightness range.
This allows it to generate just specific color with slight differences.

### Usage

##### Getting random color:
random color function can be called with parameters colorHue, colorSaturation and colorBrightness
allowing for customization of colors the generator will pass.
```dart
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

Color _color = _randomColor.randomColor();
```

##### Getting color name:
You can get color name from hex string (without # and alpha hex values) or from Color object
```dart
  Color _color = Color('FF0000'.toStringRadix(16));
  MyColor _myColor = getColorNameFromColor(_color);

  // Prints: 'Red'
  print(_myColor.getName);
```

##### Get just red colors:
Random color can generate just specific color type, as long hue, saturation and brightness are not
too limiting this will still give rich result
```dart
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

Color _color = _randomColor.randomColor(colorHue: ColorHue.red);
```

##### Get just red and blue colors:
You can combine multiple hue ranges to choose from
```dart
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

Color _color = _randomColor.randomColor(
  colorHue: ColorHue.multiple([ColorHue.red, ColorHue.blue])
);
```

##### Get highly saturated colors:
```dart
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

Color _color = _randomColor.randomColor(
  colorSaturation: ColorSaturation.highSaturation
);
```

##### Get light colors:
```dart
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

Color _color = _randomColor.randomColor(
  colorBrightness: ColorBrightness.light
);
```

### Tests

If you want to run the tests for this project under Flutter Dart

```
flutter pub pub run test
```


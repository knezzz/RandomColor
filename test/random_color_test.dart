import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:random_color/random_color.dart';

void main() {
  test('Static range test', () {
    final Range _range = Range.staticValue(10);

    expect(_range.randomWithin(Random()), 10);
    expect(_range.randomWithin(Random()), 10);
    expect(_range.randomWithin(Random()), 10);
  });

  test('Zero range test', () {
    final Range _range = Range.zero();

    expect(_range.randomWithin(Random()), 0);
    expect(_range.randomWithin(Random()), 0);
    expect(_range.randomWithin(Random()), 0);
  });

  test('Range max test', () {
    final Range _range = Range(0, 9);

    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
    expect(_range.randomWithin(Random()), lessThan(10));
  });

  test('Range min test', () {
    final Range _range = Range(91, 100);

    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
    expect(_range.randomWithin(Random()), greaterThan(90));
  });

  test('Color name test', () {
    expect(getColorNameFromString('FF0000').getName.toLowerCase(), 'red');
    expect(getColorNameFromString('00FF00').getName.toLowerCase(), 'green');
    expect(getColorNameFromString('0000FF').getName.toLowerCase(), 'blue');
  });

  test('Color generation', () {
    final RandomColor rc = RandomColor();

    final Color _redColor = rc.randomColor(
        colorHue: ColorHue.custom(Range.zero()),
        colorSaturation: ColorSaturation.custom(Range.staticValue(100)),
        colorBrightness: ColorBrightness.custom(Range.staticValue(50)));

    final Color _greenColor = rc.randomColor(
        colorHue: ColorHue.custom(Range.staticValue(120)),
        colorSaturation: ColorSaturation.custom(Range.staticValue(100)),
        colorBrightness: ColorBrightness.custom(Range.staticValue(50)));

    final Color _blueColor = rc.randomColor(
        colorHue: ColorHue.custom(Range.staticValue(240)),
        colorSaturation: ColorSaturation.custom(Range.staticValue(100)),
        colorBrightness: ColorBrightness.custom(Range.staticValue(50)));

    expect(getColorNameFromColor(_redColor).getName.toLowerCase(), 'red');
    expect(getColorNameFromColor(_greenColor).getName.toLowerCase(), 'green');
    expect(getColorNameFromColor(_blueColor).getName.toLowerCase(), 'blue');
  });
}

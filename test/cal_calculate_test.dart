import 'package:flutter_test/flutter_test.dart';
import 'package:cyclub/helpers/kcalCalc.dart';

void main() {
  test('Calories calcutation', () {
    expect(kcalCalc(30, 75, 27.3).floor(), 438);
    expect(kcalCalc(60, 70, 20).floor(), 600);
  });
}

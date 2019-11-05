import 'package:flutter_test/flutter_test.dart';
import 'package:cyclub/helpers/distance.dart';

void main() {
  test('Distance calcutation in some route coordinates', () {
    final distance1 = calculateDistance(6.32512914, -75.12341242, 6.12441334, 73.32512914);
    final distance2 = calculateDistance(4.12453332, -75.56881127, 6.65432532, 74.31232141);
    final distance3 = calculateDistance(3.12123452, -75.31232141, 6.74332421, 71.52412312);
    final distance4 = calculateDistance(3.53351356, -75.56881127, 4.12453332, 75.32421412);
    final distance5 = calculateDistance(2.12441334, -75.31232141, 3.21412111, 75.12341242);

    expect(distance1, 1);
    expect(distance2, 1);
    expect(distance3, 1);
    expect(distance4, 1);
    expect(distance5, 1);
  });
}

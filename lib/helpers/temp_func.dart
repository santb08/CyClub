
/**
 * Temporary function that calculates the kcalories given
 * the time in minutes, the weight in kg and the media of
 * the velocity during the course
 */
class Utilities {
  static double kcalCalc(time, weight, velMedia) {
    return ((velMedia * 0.1) / 14) * weight * time;
  }
}


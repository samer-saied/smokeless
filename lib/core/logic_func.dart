import 'dart:math';

class LogicFunc {
  int randomNumber({required int maxNumber}) {
    var rng = Random();
    return (rng.nextInt(maxNumber));
  }
}

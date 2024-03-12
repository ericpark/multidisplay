import 'package:multidisplay/constants.dart';

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: TICKER_DURATION_IN_SECONDS),
        (x) => ticks - x - 1).take(ticks);
  }
}

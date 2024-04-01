import 'package:multidisplay/constants.dart';

class TimerTicker {
  const TimerTicker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: TICKER_DURATION_IN_SECONDS),
        (x) => ticks - x - 1).take(ticks);
  }
}

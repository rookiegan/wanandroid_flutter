import 'dart:async';
import 'rk_string_ext.dart';

Stream<T> loop<T>(Future<T> builder(), {Duration duration = const Duration(seconds: 1)}) {
  final streamController = StreamController<T>();

  final timer = Timer.periodic(duration, (timer) async {
    if (streamController.isClosed) {
      timer.cancel();
      return;
    }
    try {
      var event = await builder();
      if (!streamController.isClosed) {
        streamController.add(event);
      }
    } catch (e) {
      "Error: $e".e();
      streamController.addError(e);
    }
  });

  streamController.onCancel = () {
    timer.cancel();
    streamController.sink.close();
  };

  return streamController.stream;
}

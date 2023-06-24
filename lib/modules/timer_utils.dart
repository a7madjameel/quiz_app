import 'dart:async';

class TimerUtils {
  StreamController<int>? controller;
  Timer? timer;

  Stream<int> countdown({int from = 11}) {
    int counter = from;

    void tick(_) {
      counter--;
      controller!.add(counter);
      if (counter == 0) {
        timer!.cancel();
        controller!.close();
      }
    }

    void startTimer() {
      timer = Timer.periodic(const Duration(seconds: 1), tick);
    }

    controller = StreamController<int>(
      onListen: startTimer,
      onCancel: () => {cancelTimer()},
    );
    return controller!.stream;
  }

  void cancelTimer() {
    timer!.cancel();
    controller!.close();
  }
}

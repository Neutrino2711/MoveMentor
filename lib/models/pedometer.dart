import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class PedoMeter {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', steps = '?';
  Future<void> initPlatformState() async {
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    // if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    print(event);

    steps = event.steps.toString();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);

    _status = event.status;
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

    _status = 'Pedestrian Status not available';

    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');

    steps = 'Step Count not available';
  }
}

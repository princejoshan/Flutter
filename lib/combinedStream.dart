
import 'dart:async';
import 'package:flutter/material.dart';

class CombinedStreamsExample extends StatefulWidget {
  const CombinedStreamsExample({super.key});

  @override
  CombinedStreamsExampleState createState() => CombinedStreamsExampleState();
}

class CombinedStreamsExampleState extends State<CombinedStreamsExample> {
  late Stream<int> _streamA;
  late Stream<int> _streamB;
  late StreamController<int> _controllerA;
  late StreamController<int> _controllerB;

  @override
  void initState() {
    super.initState();
    _controllerA = StreamController<int>();
    _controllerB = StreamController<int>();

    _streamA = _controllerA.stream;
    _streamB = _controllerB.stream;

    // Simulating emitting data after delay
    int counterA = 0;
    int counterB = 100;
    Timer.periodic(const Duration(seconds: 2), (timer) {
      counterA++;
      counterB++;
      _controllerA.add(counterA);
      _controllerB.add(counterB);
      if (counterA == 5) {
        timer.cancel(); // Stops emitting after 5 messages
        _controllerA.close();
        _controllerB.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Streams Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _streamA,
              builder: (context, snapshotA) {
                if (snapshotA.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshotA.hasError) {
                  return Text('Error: ${snapshotA.error}');
                } else if (snapshotA.hasData) {
                  return Text('Stream A: ${snapshotA.data}',
                      style: const TextStyle(fontSize: 20));
                } else {
                  return const Text('No data');
                }
              },
            ),
            StreamBuilder<int>(
              stream: _streamB,
              builder: (context, snapshotB) {
                if (snapshotB.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshotB.hasError) {
                  return Text('Error: ${snapshotB.error}');
                } else if (snapshotB.hasData) {
                  return Text('Stream B: ${snapshotB.data}',
                      style: const TextStyle(fontSize: 20));
                } else {
                  return const Text('No data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerA.close();
    _controllerB.close();
    super.dispose();
  }
}
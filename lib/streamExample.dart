import 'dart:async';
import 'package:flutter/material.dart';


class BroadcastStreamExample extends StatefulWidget {
  const BroadcastStreamExample({super.key});

  @override
  BroadcastStreamExampleState createState() => BroadcastStreamExampleState();
}

class BroadcastStreamExampleState extends State<BroadcastStreamExample> {
  late Stream<int> _stream;
  late StreamController<int> _controller;

  @override
  void initState() {
    super.initState();
    //Indicate single subscription streams
    // _controller = StreamController<int>();

    //Multipe subscription streams(updates mutiple widgets listens to this stream)
    _controller = StreamController<int>.broadcast();
    _stream = _controller.stream;

    // Simulating emitting data after delay
    int counter = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      counter++;
      _controller.add(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Broadcast Stream Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Widget 1: ${snapshot.data}',
                      style: const TextStyle(fontSize: 20));
                } else {
                  return const Text('No data');
                }
              },
            ),
            StreamBuilder<int>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Widget 2: ${snapshot.data}',
                      style: const TextStyle(fontSize: 20));
                } else {
                  return const Text('No data');
                }
              },
            ),
            ElevatedButton(
              onPressed: (){
                _controller.close();
              },
              child: Text('close stream'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
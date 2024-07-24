import 'package:flutter/material.dart';
import 'package:flutter_training/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final counter = Provider.of<Counter>(context);

    // final counter = Provider.of<Counter>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Consumer<Counter>(
          builder: (context, counter, child) {
            return Text(
              'Count: ${counter.count}',
              style: const TextStyle(fontSize: 24.0),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text(
                  'Count: ${counter.count}',
                  style: const TextStyle(fontSize: 24.0),
                );
              },
            ),
            const ButtonRow()
          ],
        ),
      ),
    );
  }

}


class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: counter.increment,
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: counter.decrement,
        ),
      ],
    );
  }
}
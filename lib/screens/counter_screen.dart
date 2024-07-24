import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
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
              style: TextStyle(fontSize: 24.0),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Text(
                  'Count: ${counter.count}',
                  style: TextStyle(fontSize: 24.0),
                );
              },
            ),
            ButtonRow()
          ],
        ),
      ),
    );
  }

}


class ButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: counter.increment,
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: counter.decrement,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({super.key});

  @override
  FutureBuilderExampleState createState() => FutureBuilderExampleState();
}

class FutureBuilderExampleState extends State<FutureBuilderExample> {

  late Future<Map<String, dynamic>> _fetchData;

  @override
  void initState() {
    super.initState();
    _fetchData = fetchData();
  }


  Future<Map<String, dynamic>> fetchData() async {

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/2'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  }

  void _refreshData() {
    setState(() {
      _fetchData = fetchData();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<Map<String, dynamic>>(
          future: _fetchData,
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // error state
            } else if (snapshot.hasData) {
              return Text('Title: ${snapshot.data!['title']}'); // success state
            } else {
              return const Text('Something went wrong'); // fallback state
            }
          },
        ),
        ElevatedButton(
          onPressed: _refreshData,
          child: const Text('Refetch Data'),
        ),
      ],
    );
  }
}
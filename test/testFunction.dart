import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestLocation(),
    );
  }
}

class TestLocation extends StatefulWidget {
  @override
  _TestLocationState createState() => _TestLocationState();
}

class _TestLocationState extends State<TestLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          print('recorded coordinate');
        },
        child: const Text('get coordinate'),
      ),
    ));
  }
}

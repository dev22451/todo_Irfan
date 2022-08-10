import 'package:flutter/material.dart';

void main() {
  runApp(todo());
}

class todo extends StatelessWidget {
  const todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: todoApp(),
    );
  }
}

class todoApp extends StatefulWidget {
  const todoApp({Key? key}) : super(key: key);

  @override
  State<todoApp> createState() => _todoAppState();
}

class _todoAppState extends State<todoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('home page'),
          ),
        ],
      ),
    );
  }
}

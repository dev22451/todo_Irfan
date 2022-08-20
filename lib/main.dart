import 'dart:ffi';
// import 'dart:js';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/todoController.dart';
import 'editPage.dart';

void main() {
  runApp(const todo());
}

class todo extends StatelessWidget {
  const todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: todoApp(
        returnData: toString(),
      ),
    );
  }
}

class Todo {
  late String name;
  // int id;
  // bool checked;
  Todo({required this.name});
  // this.checked = false;
}

class TodoItem extends StatelessWidget {
  mainController countController = Get.put(mainController());
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
          ),
        ]),
        child: ListTile(
          iconColor: Colors.white,
          onTap: (() {
            onTodoChanged(todo);
          }),
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 255, 230, 0),
            foregroundColor: Colors.black,
            child: Text(todo.name[0]),
          ),
          title: Container(
            child: Text(
              todo.name,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          subtitle: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    countController.delete(todo);
                    Get.snackbar('Successfully', 'Todo Item deleted',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.yellow,
                        colorText: Colors.black);
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              upadate(title: todo.name, items: todo)),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class todoApp extends StatefulWidget {
  todoApp({Key? key, required this.returnData}) : super(key: key);
  String returnData;

  @override
  State<todoApp> createState() => _todoAppState();
}

class _todoAppState extends State<todoApp> {
  final _formKey = GlobalKey<FormState>();
  mainController countController = Get.put(mainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Application'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.home),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: Obx(
        () => ListView(
          children: countController.todoList.map((Todo todo) {
            var index = countController.todoList.indexOf(todo);
            return TodoItem(
              todo: countController.todoList[index],
              onTodoChanged: _changeTodo,
            );
          }).toList(),
        ),
      ),
      key: _formKey,
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayList(),
          tooltip: 'Add Item',
          focusColor: Colors.green,
          foregroundColor: Colors.yellow,
          backgroundColor: Colors.black,
          mouseCursor: SystemMouseCursors.text,
          child: const Icon(Icons.add)),
    );
  }

  void _changeTodo(Todo todo) {}

  void _addTodoItem(String name) {
    countController.addText(name);
    countController.controllername.clear();
  }

  Future<void> _displayList() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 247, 0),
            title: const Text(
              'Add a new todo item',
              style: TextStyle(color: Colors.black),
            ),
            content: TextField(
              controller: countController.controllername,
              decoration: const InputDecoration(
                  hintText: 'Type your new todo', iconColor: Colors.red),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('submit',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                onPressed: () {
                  Get.snackbar('Successfully Added', 'Added todo Item in List',
                      // snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.pink,
                      colorText: Colors.white);

                  Navigator.of(context).pop();
                  _addTodoItem(countController.controllername.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

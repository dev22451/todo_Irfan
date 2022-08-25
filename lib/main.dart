// import 'dart:ffi';

// ignore_for_file: avoid_unnecessary_containers

// ignore: unnecessary_import, unused_import
import 'signup.dart';
// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/todoController.dart';
import 'editPage.dart';
import 'login.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const todo());
}

// ignore: camel_case_types
class todo extends StatelessWidget {
  const todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataSignup = GetStorage();
    dataSignup.writeIfNull('darkmode', false);

    // ignore: prefer_const_constructors
    return SimpleBuilder(builder: (_) {
      bool isDarkMode = dataSignup.read('darkmode');
      return GetMaterialApp(
        theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        // ignore: prefer_const_constructors
        home: Login(dark: isDarkMode),
      );
    });

    // GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Login(),
    // );
  }
}

class Todo {
  late String name;
  // bool Checked;

  Todo({required this.name});
}

// ignore: must_be_immutable
class TodoItem extends StatelessWidget {
  mainController countController = Get.put(mainController());
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
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
            backgroundColor: const Color.fromARGB(255, 255, 230, 0),
            foregroundColor: Colors.black,
            child: Text(todo.name[0]),
          ),
          title: Container(
            // margin: EdgeInsets.only(top: 20),
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
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// ignore: camel_case_types
class todoApp extends StatefulWidget {
  const todoApp({Key? key, required this.homeDark}) : super(key: key);
  // String returnData;
  final bool homeDark;

  @override
  State<todoApp> createState() => _todoAppState();
}

// ignore: camel_case_types
class _todoAppState extends State<todoApp> {
  final dataSignup = GetStorage();
  final box = GetStorage();
  // final _formKey = GlobalKey<FormState>();
  mainController countController = Get.put(mainController());

  @override
  Widget build(BuildContext context) {
    dataSignup.writeIfNull('todoItem', false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todo Application'),
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              dataSignup.remove('userName');
              dataSignup.remove('password');
              Get.snackbar(
                  'Account Deleted', 'plaease again register then login',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.yellow,
                  colorText: Colors.black);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Login(
                          dark: widget.homeDark,
                        )),
              );
            },
          ),
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
      // key: _formKey,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _displayList();
          },
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
          // key: _formKey,
          child: AlertDialog(
            backgroundColor: Colors.pink,
            title: const Text(
              'Add a new todo item',
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: countController.controllername,
              decoration: const InputDecoration(
                  fillColor: Colors.black,
                  hintText: 'Type your new todo',
                  focusColor: Colors.black,
                  iconColor: Colors.red),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('submit',
                    style: TextStyle(
                        color: Colors.white,
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

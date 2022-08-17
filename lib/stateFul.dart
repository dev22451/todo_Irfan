// import 'dart:ffi';
// // import 'stateFul.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp(todo());
// }

// class todo extends StatelessWidget {
//   const todo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: todoApp(),
//     );
//   }
// }

// class Todo {
//   final String name;
//   Todo({
//     required this.name,
//   });
// }

// class TodoItem extends StatelessWidget {
//   TodoItem({
//     required this.todo,
//     required this.onTodoChanged,
//   }) : super(key: ObjectKey(todo));

//   final Todo todo;
//   final onTodoChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(

//             //color: const Color(0xFF66BB6A),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black,
//                 blurRadius: 5.0,
//               ),
//             ]),
//         child: ListTile(
//           iconColor: Colors.white,
//           onTap: (() {
//             onTodoChanged(todo);
//           }),
//           leading: CircleAvatar(
//             backgroundColor: Color.fromARGB(255, 255, 230, 0),
//             foregroundColor: Colors.black,
//             child: Text(todo.name[0]),
//           ),
//           title: Container(
//             // margin: EdgeInsets.only(top: 18),
//             padding: EdgeInsets.all(15),
//             child: Text(
//               todo.name,
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ),
//           // subtitle: Container(
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.end,
//           //     children: <Widget>[
//           //       Icon(
//           //         Icons.delete,
//           //       ),
//           //     ],
//           //   ),
//           // ),
//         ));
//   }
// }

// class todoApp extends StatefulWidget {
//   const todoApp({Key? key}) : super(key: key);

//   @override
//   State<todoApp> createState() => _todoAppState();
// }

// class _todoAppState extends State<todoApp> {
//   final List<Todo> _todoList = <Todo>[];
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo Application'),
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.home),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.settings,
//               color: Colors.black,
//             ),
//             onPressed: () {},
//           )
//         ],
//         backgroundColor: Colors.yellow,
//         foregroundColor: Colors.black,
//       ),
//       body: ListView(
//         children: _todoList.map((Todo todo) {
//           return TodoItem(
//             todo: todo,
//             onTodoChanged: _changeTodo,
//           );
//         }).toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () => _displayList(),
//           tooltip: 'Add Item',
//           focusColor: Colors.green,
//           // hoverColor: Colors.blue,
//           foregroundColor: Colors.yellow,
//           backgroundColor: Colors.black,
//           mouseCursor: SystemMouseCursors.text,
//           child: Icon(Icons.add)),
//     );
//   }

//   void _changeTodo(Todo todo) {
//     // _todoList.remove(todo);
//     Get.defaultDialog(
//         title: 'Delete Item',
//         middleText: 'Delete one',
//         textConfirm: 'Okay',
//         onConfirm: () {
//           setState(() {
//             _todoList.remove(todo);
//             Navigator.of(context).pop();
//             Get.snackbar('Successfully', 'deleted this Item',
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.pink,
//                 colorText: Colors.white);
//           });
//         },
//         onCancel: () {
//           // _todoList.single;
//         },
//         confirmTextColor: Colors.white,
//         backgroundColor: Colors.yellow,
//         textCancel: 'Cancel');
//   }

//   void _addTodoItem(String name) {
//     setState(() {
//       final index = _todoList.add(Todo(
//         name: name,
//       ));
//     });
//     print('[$_todoList.indexOf(Todo(name: name, checked: false))]');

//     _controller.clear();
//   }

//   Future<void> _displayList() async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Color.fromARGB(255, 255, 247, 0),
//           title: const Text(
//             'Add a new todo item',
//             style: TextStyle(color: Colors.black),
//           ),
//           content: TextField(
//             controller: _controller,
//             decoration: const InputDecoration(
//                 hintText: 'Type your new todo', iconColor: Colors.red),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('submit',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15)),
//               onPressed: () {
//                 Get.snackbar('Successfully Added', 'Added todo Item in List',
//                     // snackPosition: SnackPosition.BOTTOM,
//                     backgroundColor: Colors.pink,
//                     colorText: Colors.white);

//                 Navigator.of(context).pop();
//                 _addTodoItem(_controller.text);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

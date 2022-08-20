import 'package:first_project/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class mainController extends GetxController {
  final List<Todo> todoList = <Todo>[].obs;

  TextEditingController controllername = TextEditingController();

  updateTodo(Todo oldTodo, String newName) {
    int index = todoList.indexOf(oldTodo);
    todoList[index].name = newName;
  }

  void addText(value) {
    todoList.add(Todo(name: value));
  }

  void delete(Todo value) {
    todoList.remove(value);
  }
}

import 'package:first_project/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class mainController extends GetxController {
  final List<Todo> todoList = <Todo>[].obs;

  // var todoList = <todo>[].obs;
  TextEditingController controllername = TextEditingController();

  void addText(value) {
    todoList.add(Todo(name: value));
  }
}

import 'dart:convert';

import 'package:first_project/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// ignore: camel_case_types
class mainController extends GetxController {
  final List<Todo> todoList = <Todo>[].obs;

  TextEditingController controllername = TextEditingController();

  final todoStore = GetStorage();

  // String storageKey = '';

  saveListWithGetStorage(String storageKey, List<Todo> todoList) async =>
      await todoStore.write(storageKey, jsonEncode(todoList));

  readWithGetStorage(String storageKey) => todoStore.read(storageKey);

  updateTodo(Todo oldTodo, String newName) {
    int index = todoList.indexOf(oldTodo);
    todoList[index].name = newName;
  }

  void addText(value) {
    todoList.add(Todo(name: value));

    todoStore.write('todoItemStore', todoList);
    print(todoStore.read('todoItemStore'));
  }

  void delete(Todo value) {
    todoList.remove(value);
  }
}

// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'main.dart';
import 'package:get/get.dart';
import 'controller/todoController.dart';

// ignore: camel_case_types
class upadate extends StatefulWidget {
  final String title;
  final Todo items;
  const upadate({Key? key, required this.title, required this.items})
      : super(key: key);
  @override
  State<upadate> createState() => _upadateState();
}

// ignore: camel_case_types
class _upadateState extends State<upadate> {
  final box = GetStorage();
  final _formKey = GlobalKey<FormState>();
  mainController countController = Get.put(mainController());
  @override
  Widget build(BuildContext context) {
    // dataSignup.writeIfNull('todoItem', false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update todo Item'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                maxLines: 1,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  } else if (text.length < 5) {
                    return 'to short';
                  }
                  return null;
                },
                onTap: () {
                  // ignore: unused_label
                  controller:
                  // ignore: unnecessary_string_interpolations
                  countController.controllername.text = '${widget.title}';
                },
                controller: countController.controllername,
                decoration: const InputDecoration(
                    labelText: 'Update Item', hintText: 'on Tap and get data')),
            FlatButton(
              // ignore: sort_child_properties_last
              child: const Text(
                'Update',
                style: TextStyle(fontSize: 20.0),
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  countController.updateTodo(
                      widget.items, countController.controllername.text);
                });

                if (_formKey.currentState!.validate()) {
                  countController.controllername.clear();
                  Get.snackbar('Successfully', 'Todo Item Update',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.yellow,
                      colorText: Colors.black);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const todoApp(homeDark: false
                            // returnData: countController.controllername.text
                            )),
                  );
                }
              },
            ),
            // Text('${box.read('storagelist')}')
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.signupDark}) : super(key: key);
  final bool signupDark;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final dataSignup = GetStorage();
  final _formKey = GlobalKey<FormState>();

  // String name = '';
  String userName = '';
  String password = '';
  String conpassword = '';
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (context) => const SignUp(
                  signupDark: true,
                )),
      );
      Get.snackbar('Successfully register', 'sucessFully registration',
          // snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.pink,
          colorText: Colors.white);
      dataSignup.write('userName', userName);
      dataSignup.write('password', password);
      // print(dataSignup.read('userName'));
      // print(dataSignup.read('password'));
      // print(object);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        // padding: const EdgeInsets.all(20),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Text('${dataSignup.read('userName')}'),
            // Text('${dataSignup.read('password')}'),
            Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.only(top: 40),
                child: const Icon(
                  Icons.app_registration_rounded,
                  color: Colors.purple,
                  size: 90,
                )),
            Container(
              alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.only(top: 40),
              child: const Text(
                ' Register',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email address';
                  }
                  // Check if the entered email has the right format
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'enter valid email address eg- irfan@gmail.com';
                  }
                  if (value == dataSignup.read('userName')) {
                    return 'All ready registered';
                  }

                  return null;
                },
                onChanged: (value) => userName = value,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined,
                        color: Colors.red),
                    border: OutlineInputBorder(),
                    labelText: 'User Name'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextFormField(
                obscureText: true,
                obscuringCharacter: "*",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'this field is required';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be atList 8 characters';
                  }
                  return null;
                },
                onChanged: (value) => password = value,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      color: Colors.red,
                    ),
                    suffixIcon: Icon(Icons.visibility),
                    border: OutlineInputBorder(),
                    labelText: 'Password'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextFormField(
                obscureText: true,
                obscuringCharacter: "*",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'this Field is required';
                  }
                  if (password != conpassword) {
                    return 'password not match';
                  }
                  return null;
                },
                onChanged: (value) => conpassword = value,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      color: Colors.red,
                    ),
                    suffixIcon: Icon(Icons.visibility),
                    border: OutlineInputBorder(),
                    labelText: ' Confirm Password'),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                // ignore: sort_child_properties_last
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: _trySubmitForm,
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.only(left: 110),
              child: Row(
                children: [
                  TextButton(
                      onPressed: (() {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp(
                                    signupDark: true,
                                  )),
                        );
                      }),
                      child: const Text(
                        'All ready registered?',
                        style: TextStyle(color: Colors.grey),
                      )),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 17, color: Colors.blue),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

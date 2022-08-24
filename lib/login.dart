// import 'SignUp.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.dark}) : super(key: key);
  final bool dark;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final dataSignup = GetStorage();

  String userId = '';
  String loginPassword = '';

  void _login() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => todoApp(
                  homeDark: widget.dark,
                  // returnData: toString(),
                )),
      );

      Get.snackbar('Successfully Login', 'sucessFully Login',
          // snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.pink,
          colorText: Colors.white);
      // print(userId);
      // print(loginPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        actions: [
          Switch(
            value: widget.dark,
            onChanged: (value) => dataSignup.write('darkmode', value),
          ),
        ],
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
                  Icons.login_outlined,
                  color: Colors.purple,
                  size: 90,
                )),
            Container(
              alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.only(top: 40),
              child: const Text(
                ' Login',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'DancingScript',
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'please enter this field';
                  }
                  if (userId != dataSignup.read('userName')) {
                    return 'Invalid User ID';
                  }
                  return null;
                },
                onChanged: (value) => userId = value,
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter this feild';
                  }
                  if (loginPassword != dataSignup.read('password')) {
                    return 'Invalid Pasword';
                  }
                  return null;
                },
                onChanged: (value) => loginPassword = value,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.password_sharp,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Password'),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
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
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: _login,
              ),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              margin: const EdgeInsets.only(left: 70),
              child: Row(
                children: [
                  TextButton(
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUp(signupDark: widget.dark)),
                        );
                      }),
                      child: const Text(
                        'Does not have an account?',
                        style: TextStyle(color: Colors.grey),
                      )),
                  const Text(
                    'SignUp',
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

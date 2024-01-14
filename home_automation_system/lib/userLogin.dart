// ignore_for_file: file_names, body_might_complete_normally_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_auth/screens/dashboard_screen.dart';
import 'package:flutter_node_auth/userRegistration.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  final _fKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showpass = true;
  bool showconpass = true;

  // ignore: non_constant_identifier_names
  Widget Email() {
    return TextFormField(
      controller: email,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Email';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget password() {
    return TextFormField(
      controller: pass,
      textInputAction: TextInputAction.next,
      obscureText: showpass,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showpass = !showpass;
              });
            },
            icon: Icon(
              showpass ? Icons.visibility_off : Icons.visibility,
            ),
          )),
    );
  }

  Widget button(String txt) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          if (_fKey.currentState!.validate()) {
            signIn(email.text, pass.text);
          }
        },
        child: Text(
          txt,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'New to this app? ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Registration()));
                    },
                    child: const Text(
                      ' Sign up',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _fKey,
                  child: Column(
                    children: [
                      Email(),
                      password(),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            button('Login'),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void signIn(String email, String pass) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ));
    await _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (route) => false);
      Fluttertoast.showToast(msg: "Login Successfull");
      Navigator.of(context).popUntil((route) => route.isFirst);
    }).catchError((e) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}

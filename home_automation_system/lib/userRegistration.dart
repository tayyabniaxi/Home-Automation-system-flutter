// ignore_for_file: file_names, body_might_complete_normally_catch_error
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_auth/userLogin.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  final _fKey = GlobalKey<FormState>();
  bool showpass = true;
  bool showconpass = true;
  final _auth = FirebaseAuth.instance;

  Widget namefield() {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'Name', prefixIcon: Icon(Icons.person)),
    );
  }

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
        //bool valemail = EmailValidator.validate(value);
        // if (valemail != true) {
        //   Fluttertoast.showToast(msg: 'Email is badley formatted');
        //   return 'Enter Valid Email';
        // }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget phoneNumber() {
    return TextFormField(
      controller: phone,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone number';
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'Phone', prefixIcon: Icon(Icons.phone)),
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
        if (value.length < 6) {
          Fluttertoast.showToast(
              msg: 'Password length Should be greater then 6 character');
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

  Widget confpassword() {
    return TextFormField(
      controller: cpass,
      obscureText: showconpass,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Confirm Password';
        }
        if (value != pass.text) {
          return "Password didn't match";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Confirm Password',
          prefixIcon: const Icon(Icons.lock_outlined),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showconpass = !showconpass;
              });
            },
            icon: Icon(
              showconpass ? Icons.visibility_off : Icons.visibility,
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
          register(name.text, email.text, phone.text, pass.text);
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
      //resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create Account',
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
                    'Already have Account? ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserLogin()));
                      });
                    },
                    child: const Text(
                      ' Login',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _fKey,
                    child: ListView(
                      children: [
                        namefield(),
                        Email(),
                        phoneNumber(),
                        password(),
                        confpassword(),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              button('Sign up'),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register(String name, String email, String phone, String pass) async {
    if (_fKey.currentState!.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      await _auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((uid) => {postDetailsToFirestore(name, email, phone, pass)})
          .catchError((e) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore(String name, String email, String phone, String pass) {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'id': user.uid,
      'Name': name,
      'Email': email,
      'Phone': phone,
      'Password': pass,
    });
    Fluttertoast.showToast(msg: "Account Created");
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const UserLogin()),
        (route) => false);
  }
}

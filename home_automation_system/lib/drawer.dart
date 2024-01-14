import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_auth/userLogin.dart';
import 'package:provider/provider.dart';

import './providers/user_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //person icon
          const Icon(
            Icons.person_rounded,
            size: 90,
            color: Color.fromARGB(255, 35, 59, 100),
          ),

          //person name
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          //person email
          Text(user.email),
          //signout button
          TextButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserLogin()));
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text("Signout"),
          ),
        ],
      ),
    );
  }
}

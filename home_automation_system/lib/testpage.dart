import 'package:flutter/material.dart';

import './lightfive.dart';
import './lightfour.dart';
import './lightone.dart';
import './lightthree.dart';
import './lighttwo.dart';

class Testpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Interactiv'),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InteractiveCard(
                  icon: Icons.lightbulb_outline,
                  text: 'Light 1',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lightone()),
                    );
                    // Navigate to Fanone screen
                  },
                ),
                InteractiveCard(
                  icon: Icons.lightbulb_outline,
                  text: 'Light 2',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lighttwo()),
                    );
                    // Navigate to Fantwo screen
                  },
                ),
              ],
            ),
          SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InteractiveCard(
                    icon: Icons.lightbulb_outline,
                    text: 'Light 3',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Lightthree()),
                      );
                      // Navigate to Fanthree screen
                    },
                  ),
                  InteractiveCard(
                    icon: Icons.lightbulb_outline,
                    text: 'Light 4',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Lightfour()),
                      );
                      // Navigate to Fanfour screen
                    },
                  ),
                  InteractiveCard(
                    icon: Icons.lightbulb_outline,
                    text: 'Light 5',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Lightfive()),
                      );
                      // Navigate to Fanfive screen
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InteractiveCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const InteractiveCard({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

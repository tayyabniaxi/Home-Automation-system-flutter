import 'package:flutter/material.dart';
import './fanone.dart';
import './fantwo.dart';
import './fanthree.dart';

class Threefans extends StatelessWidget {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InteractiveCard(
              icon: Icons.mode_fan_off_outlined,
              text: 'Fan 1',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fanone()),
                );
                // Add your camera content here
              },
            ),
            SizedBox(height: 20),
            InteractiveCard(
              icon: Icons.mode_fan_off_outlined,
              text: 'Fan 2',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fantwo()),
                );
                // Add your music content here
              },
            ),
            SizedBox(height: 20),
            InteractiveCard(
              icon: Icons.mode_fan_off_outlined,
              text: 'Fan 3',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fanthree()),
                );
                // Add your location content here
              },
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

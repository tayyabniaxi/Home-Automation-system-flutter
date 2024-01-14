import 'package:flutter/material.dart';
import 'package:flutter_node_auth/testpage.dart';

import '../temp.dart';
import '../threefans.dart';
import '../watermotor.dart';

class Mydashboard extends StatelessWidget {
  const Mydashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/homelogo.png', // Replace with your logo image path
              width: 150,
              height: 150,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  icon: Icons.lightbulb_outline,
                  label: 'Lights',
                  onPressed: () {
                    Navigator.of(context).push(_createFadeRoute());
                    // Handle button press for Lights
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Fivelighs()),
                    // );
                  },
                ),
                SizedBox(width: 20),
                CustomButton(
                  icon: Icons.mode_fan_off_outlined,
                  label: 'Fan',
                  onPressed: () {
                    Navigator.of(context).push(_createFadeRoute2());
                    // Handle button press for AC
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Threefans()),
                    // );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  icon: Icons.water,
                  label: 'Motor',
                  onPressed: () {
                    // Handle button press for Security
                    Navigator.of(context).push(_createFadeRoute3());
                  },
                ),
                SizedBox(width: 20),
                CustomButton(
                  icon: Icons.theaters,
                  label: 'Temp',
                  onPressed: () {
                    // Handle button press for Cameras
                    Navigator.of(context).push(_createFadeRoute3());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Route _createFadeRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Testpage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.ease;
      const beginOpacity = 0.0;
      const endOpacity = 1.0;

      var tween = Tween<double>(begin: beginOpacity, end: endOpacity)
          .chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration:
        Duration(seconds: 3), // Set the duration of the animation
  );
}

Route _createFadeRoute1() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Threefans(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.ease;
      const beginOpacity = 0.0;
      const endOpacity = 1.0;

      var tween = Tween<double>(begin: beginOpacity, end: endOpacity)
          .chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration:
        Duration(seconds: 3), // Set the duration of the animation
  );
}

Route _createFadeRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Watermotor(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.ease;
      const beginOpacity = 0.0;
      const endOpacity = 1.0;

      var tween = Tween<double>(begin: beginOpacity, end: endOpacity)
          .chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration:
        Duration(seconds: 5), // Set the duration of the animation
  );
}

Route _createFadeRoute3() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Temppage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.ease;
      const beginOpacity = 0.0;
      const endOpacity = 1.0;

      var tween = Tween<double>(begin: beginOpacity, end: endOpacity)
          .chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration:
        Duration(seconds: 5), // Set the duration of the animation
  );
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(icon, size: 50),
          SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 18)),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Customize button color
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// Example page widgets to be displayed upon button presses
class LightsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lights'),
      ),
      body: Center(

          // child: Text('Lights Page'),
          ),
    );
  }
}

class ACPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fan'),
      ),
      body: Center(
        child: Text('Fan Page'),
      ),
    );
  }
}

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motor'),
      ),
      body: Center(
        child: Text('Motor Page'),
      ),
    );
  }
}

class CamerasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temp'),
      ),
      body: Center(
        child: Text('Temp Pgae'),
      ),
    );
  }
}
//
// void main() {
//   runApp(MaterialApp(
//     home: HomeScreen(),
//   ));
// }

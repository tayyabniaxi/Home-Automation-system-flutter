import 'package:flutter/material.dart';
import 'package:flutter_node_auth/drawer.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '/temp.dart';
import '/threefans.dart';
import '/watermotor.dart';
import '/testpage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _MydashboardScreenState();
}

class _MydashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                "Home Automation System",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
          drawer: Drawer(
            child: MyDrawer(),
          ),
          body: Container(
            color: Colors.blue.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                      child: Text(
                        "Hi ${user.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.front_hand,
                        color: Colors.orange,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TabBar(
                    labelColor: Colors.black45,
                    tabs: <Widget>[
                      Tab(
                        text: "Fan Control",
                      ),
                      Tab(
                        text: "Light Control",
                      ),
                      Tab(
                        text: "Temp Control",
                      ),
                      Tab(
                        text: "Motor Control",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Threefans(),
                      Testpage(), // Room2 content
                      Temppage(),
                      Watermotor(),
                      // Room3 content
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomTab(int roomIndex) {
    return Center(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        itemCount: 4, // 4 cards in each room
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.lightbulb_outline, size: 48.0),
                ),
                Text(
                  'Card ${index + 1}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press and navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextPage()),
                    );
                  },
                  child: Text('Go to Next Page'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('This is the next page.'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({super.key, required this.title});

  final String title;

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width *
          0.75, // 75% of screen will be occupied
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                  colors: [Colors.deepPurpleAccent, Colors.blueAccent],
                  begin: Alignment.centerRight,
                  end: Alignment(-1.0, -1.0),
                ),
              ),
              child: null,
            ),
            const SizedBox(height: 20),
            ListTile(
              //leading: Icon(Icons.category),
              title: const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Add your onTap logic here
              },
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: 30, color: Colors.blueAccent[100]),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Personal',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.list_alt,
                          size: 30, color: Colors.blueAccent[100]),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Wishlist',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.cake, size: 30, color: Colors.blueAccent[100]),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Birthday',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Divider(height: 2),
            ListTile(
              leading:
                  Icon(Icons.reorder, size: 30, color: Colors.blueAccent[100]),
              title: const Text('Reorder Tasks'),
              onTap: () {
                // Add your onTap logic for item 1 here
              },
            ),
            ListTile(
              leading: Icon(Icons.workspace_premium,
                  size: 30, color: Colors.blueAccent[100]),
              title: const Text('Premium'),
              onTap: () {
                // Add your onTap logic for item 2 here
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.star, size: 30, color: Colors.blueAccent[100]),
              title: const Text('Rate us'),
              onTap: () {
                // Add your onTap logic for item 2 here
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.settings, size: 30, color: Colors.blueAccent[100]),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pushNamed(context, '/setting');
              },
            ),
          ],
        ),
      ),
    );
  }
}

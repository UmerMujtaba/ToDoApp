import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({super.key, required this.title});

  final String title;

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
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
                    colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
                    begin: Alignment.centerRight,
                    end: Alignment(-1.0, -1.0),
                  ),
                ),
                child: null,
              ),
              const SizedBox(height: 10),
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
                  // Navigator.maybePop(context, '/d');
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
                        Icon(Icons.cake,
                            size: 30, color: Colors.blueAccent[100]),
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
                // trailing: IconButton(
                //     icon: const Icon(
                //       Icons.arrow_drop_down_sharp,
                //       size: 40,
                //       color: Colors.deepPurpleAccent,
                //     ),
                //     onPressed: () {})
              ),
              const Divider(height: 2),
              ListTile(
                leading: Icon(Icons.reorder,
                    size: 30, color: Colors.blueAccent[100]),
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
                  Navigator.pushNamed(context, '/premium');
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.star, size: 30, color: Colors.blueAccent[100]),
                title: const Text('Rate us'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings,
                    size: 30, color: Colors.blueAccent[100]),
                title: const Text('Setting'),
                onTap: () {
                  Navigator.pushNamed(context, '/setting');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({super.key, required this.title});

  final String title;

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
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
              ),
              const Divider(height: 2),
              ListTile(
                leading: Icon(Icons.backup_outlined,
                    size: 30, color: Colors.blueAccent[100]),
                title: const Text('Back up'),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              ListTile(
                leading: Icon(Icons.restore,
                    size: 30, color: Colors.blueAccent[100]),
                title: const Text('Restore'),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
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

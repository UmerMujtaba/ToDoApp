import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/todo_Class.dart';
import '../model/todo_Provider.dart';
import '../provider/provider_backup_restore.dart';
import '../services/firebase_Service.dart';

class DrawerApp extends ConsumerWidget {
  final String title;
  // final List<Todo> todos; // Add todos parameter

  const DrawerApp({Key? key, required this.title});


  // final FirebaseService firebaseService = FirebaseService();
  // final TodoProvider todoProvider = TodoProvider();
  // List<Todo> todos = <Todo>[];

  Future<bool> _checkIfLoggedIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Not Logged In'),
          content: const Text(
              'You need to log in or register to perform this action.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Register'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushNamed(context, '/register').then((_) {
                  Navigator.pushNamed(context, '/login');
                });
              },
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoStateNotifier = ref.watch(todoStateNotifierProvider);
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.75, // 75% of screen will be occupied
        child: Drawer(
          backgroundColor: Colors.black,

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
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                onTap: () {
                  // Navigator.maybePop(context, '/d');
                },
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(Icons.person,
                            size: 30, color: Colors.blueAccent),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Personal',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.list_alt,
                            size: 30, color: Colors.blueAccent),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Wishlist',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.cake,
                            size: 30, color: Colors.blueAccent),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Birthday',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              const Divider(height: 2),
              ListTile(
                leading: const Icon(Icons.backup_outlined,
                    size: 30, color: Colors.blueAccent),
                title: const Text(
                  'Back up',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onTap: () async {
                  bool isLoggedIn = await _checkIfLoggedIn();
                  if (!isLoggedIn) {
                    _showSnackbar(
                        context, 'You need to log in or register first.');
                    // Handle login or registration flow
                  } else {
                    await ref
                        .read(todoStateNotifierProvider.notifier)
                        .backupTodos(context);
                    Navigator.pop(context); // Close the drawer after backup
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.restore,
                    size: 30, color: Colors.blueAccent),
                title: const Text(
                  'Restore',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onTap: () async {
                  await ref
                      .read(todoStateNotifierProvider.notifier)
                      .restoreTodos(context);
                  Navigator.pop(context); // Close the drawer after restore
                },
              ),
              ListTile(
                leading: const Icon(Icons.workspace_premium,
                    size: 30, color: Colors.blueAccent),
                title: const Text('Premium',style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.pushNamed(context, '/premium');
                 // Navigator.pop(context); // Close
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings,
                    size: 30, color: Colors.blueAccent),
                title: const Text('Setting',style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.pushNamed(context, '/setting');
                  //Navigator.pop(context); // Close
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



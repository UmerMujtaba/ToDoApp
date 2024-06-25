import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/todo_Class.dart';
import '../model/todo_Provider.dart';
import '../services/firebase_service.dart';

class DrawerApp extends StatefulWidget {
  final String title;
  final List<Todo> todos; // Add todos parameter

  const DrawerApp({Key? key, required this.title, required this.todos});

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  final FirebaseService firebaseService = FirebaseService();
  final TodoProvider todoProvider = TodoProvider();
  List<Todo> todos = <Todo>[];

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

  Future<void> _loadTodos() async {
    try {
      List<Todo> loadedTodos = await todoProvider.getAllTodos();
      setState(() {
        todos.clear();
        todos.addAll(loadedTodos);
      });
      print('Fetched ${loadedTodos.length} todos: $loadedTodos');
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  Future<void> _backupTodos(BuildContext context) async {
    try {
      print('Opening database...');
      await todoProvider.open('sample'); // Open the database

      print('Fetching todos...');
      await _loadTodos(); // Ensure todos are loaded before backup
      print('Fetched ${todos.length} todos: $todos');

      print('Backing up todos to Firestore...');
      await firebaseService.backupTodosToFirestore(todos);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup successful.')),
      );

      print('Local database closed.');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup failed: $e')),
      );
      print('Backup failed: $e');
    } finally {
      await todoProvider.close(); // Always ensure database is closed
    }
  }

  @override
  Widget build(BuildContext context) {
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
                title: const Text('Back up',style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () async {
                  bool isLoggedIn = await _checkIfLoggedIn();
                  if (!isLoggedIn) {
                    _showSnackbar(
                        context, 'You need to log in or register first.');
                    _showDialog(context);
                  } else {
                    await _backupTodos(context);
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.restore,
                    size: 30, color: Colors.blueAccent),
                title: const Text('Restore',style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              ListTile(
                leading: const Icon(Icons.workspace_premium,
                    size: 30, color: Colors.blueAccent),
                title: const Text('Premium',style: TextStyle(fontSize: 16, color: Colors.white),),
                onTap: () {
                  Navigator.pushNamed(context, '/premium');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings,
                    size: 30, color: Colors.blueAccent),
                title: const Text('Setting',style: TextStyle(fontSize: 16, color: Colors.white),),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/model/todo_Class.dart';
import 'package:todoapp/provider/provider_backup_restore.dart';
import 'package:todoapp/screens/firstscreen/returning_List.dart';
import 'package:todoapp/screens/firstscreen/show_Dialog.dart';
import 'package:todoapp/screens/firstscreen/category.dart'; // Assuming this is where TodoProvider is defined
import 'package:todoapp/component/drawer.dart';
import 'package:todoapp/component/bottom_Bar.dart';

import '../model/todo_Provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  final TodoProvider todoProvider;

  const MainScreen({Key? key, required this.todoProvider}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late TodoProvider _todoProvider;
  List<Todo> todos = <Todo>[];
  bool _isDatabaseInitialized = false;

  @override
  void initState() {
    super.initState();
    _todoProvider = widget.todoProvider;
_loadTodos();
    openDatabase();
  }

  Future<void> _loadTodos() async {
    try {
      List<Todo> loadedTodos = await _todoProvider.getAllTodos();
      setState(() {
        todos.clear();
        todos.addAll(loadedTodos);
      });
      print('Fetched ${loadedTodos.length} todos: $loadedTodos');
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  Future<void> _restoreTodos() async {
    try {
      await ref.read(todoStateNotifierProvider.notifier).restoreTodos(context);
    } catch (e) {
      print('Error restoring todos: $e');
    }
  }

  // Future<void> _loadTodos() async {
  //   try {
  //
  //     final result=await ref.read(todoStateNotifierProvider.notifier).loadTodos();
  //     print("result-----");
  //   } catch (e) {
  //     print('Error loading todos: $e');
  //     // Handle error as needed
  //   }
  // }

  Future<void> openDatabase() async {
    try {
      await _todoProvider
          .open('sample'); // Open the database with the desired name
      setState(() {
        _isDatabaseInitialized = true;
      });
      await _loadTodos();
      print('Database opened successfully from main screen');
    } catch (e) {
      print('Error opening database: $e');
      // Handle error as needed
    }
  }

  @override
  void dispose() {
    //_todoProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDatabaseInitialized) {
      // Handle case where database is not yet initialized
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final todos = ref.watch(todoStateNotifierProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.notifications,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey,
                      size: 30,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 0, 20),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const CategoryRow(),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 15, 0, 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ReturnList(
                todos: todos,
                todoProvider: _todoProvider,
              ),
            ],
          ),
        ),
      ),
      drawer: const DrawerApp(
        title: 'New',
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent[80],
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DisplayAlertDialog(
                todo: null,
                onTodoUpdated: _loadTodos,
              );
            },
          );
        },
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const Bar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/model/todo_Class.dart';
import '/component/drawer.dart';
import '/component/bottom_Bar.dart';
import '/model/todo_Provider.dart';
import 'firstscreen/returning_List.dart';
import 'firstscreen/show_Dialog.dart';
import 'firstscreen/category.dart';

class MainScreen extends StatefulWidget {
  final TodoProvider todoProvider;

  const MainScreen({super.key, required this.todoProvider});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TodoProvider _todoProvider;
  List<Todo> todos = <Todo>[];
  Todo? _editingTodo;

  @override
  void initState() {
    super.initState();
    _todoProvider = widget.todoProvider;
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

  Future<void> openDatabase() async {
    try {
      await _todoProvider
          .open('sample'); // Open the database with the desired name
      print('Database opened successfully');
      await _loadTodos();
    } catch (e) {
      print('Error opening database: $e');
    }
  }

  @override
  void dispose() {
    _todoProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = TodoProvider();
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
                todoProvider: _todoProvider,
                todos: todos,
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerApp(
        title: 'New',
        //todos: todos,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent[80],
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DisplayAlertDialog(
                todoProvider: _todoProvider,
                todo: null,
                onTodoUpdated: () {
                  setState(
                    () {
                      _loadTodos(); //used to load todos after adding or updating
                    },
                  );
                },
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

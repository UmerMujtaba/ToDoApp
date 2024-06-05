
import 'package:flutter/material.dart';
import 'package:instagramclone/screens/firstscreen/ReturningList.dart';
import '/model/TodoClass.dart';
import '/component/DrawerCheck.dart';
import '/component/BottomBar.dart';
import '/model/TodoProvider.dart';
import 'firstscreen/ShowDialog.dart';
import 'firstscreen/Category.dart';

class Firstscreen extends StatefulWidget {
  final TodoProvider todoProvider;

  const Firstscreen({super.key, required this.todoProvider});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  late TodoProvider _todoProvider;

  final List<Todo> todos = <Todo>[];
  Todo? _editingTodo;


  @override
  void initState() {
    super.initState();
    _todoProvider = widget.todoProvider;
    // openDatabase();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    print('load todos of first screen dialog');
    try {
      List<Todo> loadedTodos = await _todoProvider.getAllTodos();
      setState(() {
        todos.clear();
        todos.addAll(loadedTodos);
      });
    } catch (e) {
      print('Error loading todos: $e');
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
      backgroundColor: Colors.white,
      body:  SafeArea(
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
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ReturnList(todoProvider: todoProvider),
            ],
          ),
        ),
      ),
      drawer: const drawer(
        title: 'New',
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent[80],
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TodoProvider todoProvider = TodoProvider();
              return DisplayAlertDialog(todoProvider: todoProvider, todo: null, onTodoUpdated: _loadTodos);
            },
          );
        },
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const bar(),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import '../component/DrawerCheck.dart';
import '../component/BottomBar.dart';
import '../model/todo.dart';
import 'package:image_picker/image_picker.dart';

import '../model/todoitem.dart';
import '../model/todoprovider.dart';
import 'DisplayDialog.dart';

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
  Color _selectedColor = Colors.grey;
  File? galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> openDatabase() async {
    try {
      await _todoProvider
          .open('sample'); // Open the database with the desired name
      print('Database opened successfully');
    } catch (e) {
      print('Error opening database: $e');
    }
  }


  Future<void> _deleteTodoItem(Todo todo) async {
    try {
      await _todoProvider.delete(todo.id!); // Ensure id is not null
      setState(() {
        todos.removeWhere((element) => element.id == todo.id);
      });
    } catch (e) {
      print('Error deleting todo item: $e');
    }
  }

  @override
  void dispose() {
    _todoProvider.close();
    super.dispose();
  }


  //Handle Change function for todo list
  void handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  //add to do item function


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 130,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.purple,
                      gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
                          begin: Alignment.centerRight,
                          end: Alignment(-1.0, -1.0)),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                              child: Text(
                                'Personal',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 130,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.purple,
                      gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
                          begin: Alignment.centerRight,
                          end: Alignment(-1.0, -1.0)),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 14, 0, 0),
                              child: Text(
                                'Birthday',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  children: todos.map((Todo todo) {
                    return TodoItem(
                        todo: todo,
                        onTodoChanged: handleTodoChange,
                        removeTodo: _deleteTodoItem,
                        onTodoEdit: () {
                          // Access context using the Builder widget
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Assuming todoProvider is accessible from the same widget tree
                              TodoProvider todoProvider = TodoProvider();
                              return DisplayAlertDialog(
                                  todoProvider: todoProvider, todo: todo);
                            },
                          );
                        });
                  }).toList(),
                ),
              ),
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
              return DisplayAlertDialog(todoProvider: todoProvider, todo: null);
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



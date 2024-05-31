import 'dart:io';
import 'package:flutter/material.dart';
import '../component/DrawerCheck.dart';
import '../component/BottomBar.dart';
import 'todo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';


class Firstscreen extends StatefulWidget {
  const Firstscreen({Key? key}) : super(key: key);

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  final List<Todo> todos = <Todo>[];

  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();
  String _selectedPriority = 'Medium';
  Todo? _editingTodo;
  Color _selectedColor = Colors.red[300]!;
  File? galleryFile;
  final picker = ImagePicker();



  //Handle Change function for todo list
  void handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  //Remove To Do function to delete a to do
  void _deleteTodo(Todo todo) {
    setState(() {
      todos.removeWhere((element) => element.title == todo.title);
    });
  }

  //add to do item function
  void _addOrUpdateTodoItem(
      Todo? todo, String title, String name, String text, String color) {
    if (todo != null) {
      // Update existing todo
      setState(() {
        todo.title = title;
        todo.name = name;
        todo.text = text;
        todo.color = color;
      });
    } else {
      // Add new todo
      setState(() {
        todos.add(Todo(
          title: title,
          name: name,
          completed: false,
          text: text,
          color: color,

        ));
      });
    }

    _textFieldController.clear();
    _textFieldController2.clear();
    _textFieldController3.clear();
  }

  // Display dialog for adding/editing a todo
  Future<void> display({Todo? todo}) async {
    if (todo != null) {
      _textFieldController.text = todo.title;
      _textFieldController2.text = todo.name;
      _textFieldController3.text = todo.text;
      _selectedPriority = todo.color;
      _selectedColor = _getPriorityColor(todo.color);
    } else {
      _textFieldController.clear();
      _textFieldController2.clear();
      _textFieldController3.clear();
      _selectedPriority = 'Medium';
      _selectedColor = Colors.red[300]!;
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 360.0,
          height: 400.0,
          child: AlertDialog(
            title: const Text(
              'Create a new task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              padding: const EdgeInsets.all(0),
              width: 600.0,
              height: 400.0,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                    width: 180,
                    child: TextField(
                      controller: _textFieldController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Title'), //act as a placeholder
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                    width: 180,
                    child: TextField(
                      controller: _textFieldController2,
                      decoration: const InputDecoration(
                          hintText: 'Enter Description'), //act as a placeholder
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        'Priorities',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedPriority = 'High';
                              _selectedColor = Colors.blue[400]!;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          child: const SizedBox(
                            width: 20,
                            child: Text(
                              'High',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedPriority = 'Medium';
                              _selectedColor = Colors.orange[300]!;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[300],
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          child: const Text(
                            'Medium',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedPriority = 'Low';
                              _selectedColor = Colors.orange[300]!;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[300],
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          child: const SizedBox(
                            width: 22,
                            child: Text(
                              'Low',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        'Attachment',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                style: BorderStyle.solid, width: 1.0)),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.black,
                          iconSize: 20,
                          onPressed: () {
                            _showPicker(context: context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent[100],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addOrUpdateTodoItem(
                      todo,
                      _textFieldController.text,
                      _textFieldController2.text,
                      _textFieldController3.text,
                      _selectedPriority,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Create a Task',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.blue[400]!;
      case 'Medium':
        return Colors.red[300]!;
      case 'Low':
        return Colors.orange[300]!;
      default:
        return Colors.red[300]!;
    }
  }

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
                        removeTodo: _deleteTodo,
                        onTodoEdit: () => display(todo: todo));
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
        onPressed: () => display(),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const bar(),
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    required this.removeTodo,
    required this.onTodoEdit,
  }) : super(key: Key(todo.title));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;
  final VoidCallback onTodoEdit;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
       InkWell(
        onTap: onTodoEdit,
        child: Container(
          height: 86,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text(
                      todo.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          todo.name,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getPriorityColor(todo.color),
                        elevation: 5,
                        // Use the priority color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        onTodoChanged(todo);
                      },
                      child: Text(
                        todo.color,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        removeTodo(todo);
                      },
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Color _getPriorityColor(String priority) {
    Color? color;
    switch (priority) {
      case 'High':
        color = Colors.blue[400];
        break;
      case 'Medium':
        color = Colors.red[300];
        break;
      case 'Low':
        color = Colors.orange[300];
        break;
    }
    return color ?? Colors.grey; // Use Colors.grey as a fallback color
  }
}

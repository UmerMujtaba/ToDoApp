import 'package:flutter/material.dart';
import 'dart:io';
import '../model/todo.dart';
import 'package:image_picker/image_picker.dart';
import '../model/todoprovider.dart';

class DisplayAlertDialog extends StatefulWidget {
  final Todo? todo;

  final TodoProvider todoProvider;

  const DisplayAlertDialog({Key? key, required this.todoProvider, this.todo})
      : super(key: key);

  @override
  _DisplayAlertDialogState createState() => _DisplayAlertDialogState();
}

class _DisplayAlertDialogState extends State<DisplayAlertDialog> {
  TodoProvider todoprovider = TodoProvider();

  final List<Todo> todos = <Todo>[];
  late TextEditingController _textFieldController;
  late TextEditingController _textFieldController2;
  late TextEditingController _textFieldController3;
  String _selectedPriority = '';
  late Color _selectedColor;
  late TodoProvider _todoProvider;

  void _addOrUpdateTodoItem(
      Todo? todo, String title, String description, String text, String color) {
    if (todo != null) {
      // Update existing todo
      setState(() {
        todo.title = title;
        todo.description = description;
        todo.text = text;
        todo.color = color;
      });
    } else {
      // Add new todo
      setState(() {
        todos.add(Todo(
          title: title,
          description: description,
          completed: false,
          text: text,
          color: color,
        ));
      });
    }
  }

  Future<void> _loadTodos() async {
    try {
      List<Todo> loadedTodos = await _todoProvider
          .getAllTodos(); // Use _todoProvider instead of widget.todoProvider
      setState(() {
        todos.clear();
        todos.addAll(loadedTodos);
      });
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  @override
  void initState() {
    _todoProvider = TodoProvider(); // Initialize _todoProvider
    // Use the instance passed through the constructor
    _todoProvider.open('sample.db').then((_) {
      print('Database opened');
      _loadTodos();
    }).catchError((e) {
      print('Error opening database: $e');
    });

    super.initState();
    _textFieldController = TextEditingController();
    _textFieldController2 = TextEditingController();
    _textFieldController3 = TextEditingController();
    if (widget.todo != null) {
      _textFieldController.text = widget.todo!.title;
      _textFieldController2.text = widget.todo!.description;
      _textFieldController3.text = widget.todo!.text;
      _selectedPriority = widget.todo!.color;
      _selectedColor = _getPriorityColor(widget.todo!.color);
    } else {
      _selectedPriority = '';
      _selectedColor = Colors.red[300]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.0,
      height: 400.0,
      child: AlertDialog(
        title: const Text(
          'Create new task',
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
                    'description',
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
                      hintText: 'Enter description'), //act as a placeholder
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedPriority == 'High'
                              ? Colors.red[300]
                              : Colors.grey,
                          elevation: _selectedPriority == 'High' ? 20 : 5,
                          minimumSize: _selectedPriority == 'High'
                              ? const Size.square(45)
                              : const Size.square(35),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      onPressed: () {
                        setState(() {
                          _selectedPriority = 'High';
                          print(_selectedPriority);
                          _textFieldController3.text = _selectedPriority;

                          // _selectedColor = Colors.green!;
                        });
                      },
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
                          print(_selectedPriority);
                          _textFieldController3.text = _selectedPriority;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedPriority == 'Medium'
                              ? Colors.orange[300]
                              : Colors.grey,
                          elevation: _selectedPriority == 'Medium' ? 20 : 5,
                          minimumSize: _selectedPriority == 'Medium'
                              ? const Size.square(45)
                              : const Size.square(35),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: const SizedBox(
                        width: 35,
                        child: Text(
                          'Medium',
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
                          _selectedPriority = 'Low';
                          print(_selectedPriority);
                          _textFieldController3.text = _selectedPriority;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedPriority == 'Low'
                              ? Colors.blue[300]
                              : Colors.grey,
                          elevation: _selectedPriority == 'Low' ? 20 : 5,
                          minimumSize: _selectedPriority == 'Low'
                              ? const Size.square(45)
                              : Size.square(35),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: const SizedBox(
                        width: 20,
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
                        border:
                            Border.all(style: BorderStyle.solid, width: 1.0)),
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
              onPressed: () async {
                Navigator.of(context).pop();
                _addOrUpdateTodoItem(
                  widget.todo,
                  _textFieldController.text,
                  _textFieldController2.text,
                  _textFieldController3.text,
                  _selectedPriority,
                );

                Todo newTodo = Todo(
                  title: _textFieldController.text,
                  description: _textFieldController2.text,
                  completed: false,
                  text: _textFieldController3.text,
                  color: _selectedPriority,
                );

                if (widget.todo == null) {
                  print('Going to insert');
                  await widget.todoProvider.insert(newTodo);
                } else {
                  await widget.todoProvider.update(newTodo);
                }

                // Clear text fields
                _textFieldController.clear();
                _textFieldController2.clear();
                _textFieldController3.clear();

                // Reload todos
                await _loadTodos();
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Create Task',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red[400]!;
      case 'Medium':
        return Colors.orange[300]!;
      case 'Low':
        return Colors.blue[300]!;
      default:
        return Colors.grey;
    }
  }

  void _showPicker({required BuildContext context}) {
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

  Future getImage(ImageSource img) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: img);
    if (pickedFile != null) {
      final galleryFile = File(pickedFile.path);
      // Handle the picked image
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing is selected')),
      );
    }
  }
}

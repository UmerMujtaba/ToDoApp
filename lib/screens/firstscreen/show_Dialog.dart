import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '/model/todo_Class.dart';
import 'package:image_picker/image_picker.dart';
import '/model/todo_Provider.dart';

class DisplayAlertDialog extends StatefulWidget {
  final Todo? todo;
  final VoidCallback onTodoUpdated;

  const DisplayAlertDialog({
    Key? key,
    this.todo,
    required this.onTodoUpdated,
  }) : super(key: key);

  @override
  _DisplayAlertDialogState createState() => _DisplayAlertDialogState();
}

class _DisplayAlertDialogState extends State<DisplayAlertDialog> {
  late TodoProvider _todoProvider;
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();
  String _selectedPriority = 'Low';
  Color _selectedColor = Colors.red[300]!;
  //late List<Todo> _todos;
  @override
  void initState() {
    super.initState();
   // _todos = widget.todo as List<Todo>;
    if (widget.todo != null) {
      _textFieldController.text = widget.todo!.title;
      _textFieldController2.text = widget.todo!.description;
      _textFieldController3.text = widget.todo!.text;
      _selectedPriority = widget.todo!.color;
      _selectedColor = _getPriorityColor(widget.todo!.color);
    }

    _todoProvider = TodoProvider();
    _todoProvider.open('sample').then((_) {
      print('Database opened');
    }).catchError((e) {
      print('Error opening database: $e');
    });
    //_loadTodos();
  }


  //add or update item
  Future<void> _addOrUpdateTodoItem(Todo? todo, String title,
      String description, String text, String color) async {
    if (todo != null) {
      // Update existing todo
      todo.title = title;
      todo.description = description;
      todo.text = text;
      todo.color = color;
      await _todoProvider.update(todo);
    } else {
      // Add new todo
      Todo newTodo = Todo(
        uid:const Uuid().v4(),
        title: title,
        description: description,
        completed: false,
        text: text,
        color: color,
      );
      await _todoProvider.insert(newTodo);
    }
    widget.onTodoUpdated();
  }


  //get Priority
  Color _getPriorityColor(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
  Future<void> _loadTodos() async {
    print('load todos of return list screen ');
    try {
      List<Todo> loadedTodos = await _todoProvider.getAllTodos();

      setState(() {
        //print("okokokokok-------${_todoProvider}");
        loadedTodos.clear();
        loadedTodos.addAll(loadedTodos);
      });
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  //dispose func
  @override
  void dispose() {
    // Dispose of the controllers to free up resources
    print('Disposing of DisplayAlertDialog');
    _textFieldController.dispose();
    _textFieldController2.dispose();
    _textFieldController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.0,
      height: 400.0,
      child: AlertDialog(
        backgroundColor: Colors.grey,
        title: Text(
          widget.todo == null ? 'Create a Todo' : 'Update Todo',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
                width: 180,
                child: TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Title',
                  ),
                  autofocus: true,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
                width: 180,
                child: TextField(
                  controller: _textFieldController2,
                  decoration: const InputDecoration(
                    hintText: 'Enter Description',
                  ),
                  autofocus: true,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    'Priorities',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
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
                            ? Colors.red[400]
                            : Colors.grey,
                        elevation: _selectedPriority == 'High' ? 20 : 5,
                        minimumSize: _selectedPriority == 'High'
                            ? const Size.square(45)
                            : const Size.square(35),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedPriority = 'High';
                          _textFieldController3.text = _selectedPriority;
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
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
                            : const Size.square(35),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
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
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
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
                      border: Border.all(style: BorderStyle.solid, width: 1.0),
                    ),
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
                String title = _textFieldController.text;
                String description = _textFieldController2.text;
                String text = _textFieldController3.text;
                String color = getColorForPriority(_selectedPriority);

                await _addOrUpdateTodoItem(
                    widget.todo, title, description, text, color);

                widget.onTodoUpdated();

                Navigator.of(context).pop(true);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.todo == null ? 'Add Todo' : 'Update Todo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  //get priority color
  String getColorForPriority(String selectedPriority) {
    if (selectedPriority == "High") {
      return "Red";
    } else if (selectedPriority == "Medium") {
      return "Orange";
    } else {
      return "Blue";
    }
  }
}

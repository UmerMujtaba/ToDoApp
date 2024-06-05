import 'package:flutter/material.dart';
import '/model/todo.dart';
import '/model/todoitem.dart';
import '/model/todoprovider.dart';
import 'DisplayDialog.dart';

class ReturnList extends StatefulWidget {
  final TodoProvider todoProvider;

  const ReturnList({Key? key, required this.todoProvider}) : super(key: key);

  @override
  State<ReturnList> createState() => _ReturnListState();
}

class _ReturnListState extends State<ReturnList> {
  List<Todo> todos = <Todo>[];
  late TodoProvider _todoProvider;

  Todo? _editingTodo;

  //Color _selectedColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _todoProvider = widget.todoProvider;
    openDatabase();
    _loadTodos();
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

  Future<void> _loadTodos() async {
    print('load todos of return list screen ');
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

  // Future<void> _loadTodos() async {
  //   List<Todo> loadedTodos = await widget.todoProvider.getAllTodos();
  //   setState(() {
  //     todos = loadedTodos;
  //   });
  // }

  void handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
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
  Widget build(BuildContext context) {
    TodoProvider todoProvider = TodoProvider();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoItem(
            key: UniqueKey(),
            // Add a unique key for each TodoItem
            todo: todos[index],
            onTodoChanged: handleTodoChange,
            removeTodo: (Todo todo) {
              // Modify the signature to accept a Todo parameter
              _deleteTodoItem(
                  todo); // Pass the todo item to the _deleteTodoItem function
            },
            onTodoEdit: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DisplayAlertDialog(
                    todoProvider: _todoProvider,
                    todo: todos[index],
                      onTodoUpdated: _loadTodos
                    // Pass the specific todo item to the dialog
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

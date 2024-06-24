import 'package:flutter/material.dart';
import '/model/todo_Class.dart';
import 'todo_Item.dart';
import '/model/todo_Provider.dart';
import 'show_Dialog.dart';

class ReturnList extends StatefulWidget {
  final TodoProvider todoProvider;
  final List<Todo> todos;

  const ReturnList({Key? key, required this.todoProvider, required this.todos})
      : super(key: key);

  @override
  State<ReturnList> createState() => _ReturnListState();
}

class _ReturnListState extends State<ReturnList> {
  late TodoProvider _todoProvider;
  late final List<Todo> _todos;

  Todo? _editingTodo;

  @override
  void initState() {
    super.initState();
    _todoProvider = widget.todoProvider;
    _todos = widget.todos;
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
        _todos.clear();
        _todos.addAll(loadedTodos);
      });
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  void handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  Future<void> _deleteTodoItem(Todo todo) async {
    try {
      await _todoProvider.delete(todo.id!); // Ensure id is not null
      setState(() {
        _todos.removeWhere((element) => element.id == todo.id);
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
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return TodoItem(
            key: UniqueKey(),
            // Add a unique key for each TodoItem
            todo: _todos[index],
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
                    todo: _todos[index],
                    onTodoUpdated: _loadTodos,
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

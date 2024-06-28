import 'package:flutter/material.dart';

import '/model/todo_Class.dart';
import 'todo_Item.dart';
import 'show_Dialog.dart';
import '/model/todo_Provider.dart';

class ReturnList extends StatefulWidget {
  final List<Todo> todos;
final TodoProvider todoProvider;

  const ReturnList({Key? key, required this.todos, required this.todoProvider}) : super(key: key);

  @override
  State<ReturnList> createState() => _ReturnListState();
}

class _ReturnListState extends State<ReturnList> {

  late List<Todo> _todos;
  late TodoProvider _todoProvider;

  @override
  void initState() {
    super.initState();
    _todos = widget.todos;
    _todoProvider = widget.todoProvider;
    _loadTodos();
  }

  //load todos
  Future<void> _loadTodos() async {
    print('load todos of return list screen ');
    try {
      List<Todo> loadedTodos = await _todoProvider.getAllTodos();

      setState(() {
        print("okokokokok-------${_todos}");
        _todos.clear();
        _todos.addAll(loadedTodos);
      });
    } catch (e) {
      print('Error loading todos: $e');
    }
  }


  //handle todo change
  void handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }


  //delete todo item
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

   // print(_todos);
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
            todo: _todos[index],
            onTodoChanged: handleTodoChange,
            removeTodo: (Todo todo) {
              _deleteTodoItem(todo);
            },
            onTodoEdit: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DisplayAlertDialog(
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

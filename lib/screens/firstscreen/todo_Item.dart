import 'package:flutter/material.dart';
import '../../model/todo_Class.dart';
import '../../model/todo_Provider.dart';

class TodoItem extends StatefulWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
    required this.removeTodo,
    required this.onTodoEdit,
    required UniqueKey key,
  }) : super(key: Key(todo.title));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;
  final VoidCallback onTodoEdit;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final List<Todo> todos = <Todo>[];
  late TodoProvider _todoProvider;

  @override
  void initState() {
    super.initState();
  }

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTodoEdit,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
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
                        widget.todo.title,
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
                            widget.todo.description,
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
                          backgroundColor: _getPriorityColor(widget.todo.color),
                          elevation: 5,
                          // Use the priority color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          widget.onTodoEdit();
                        },
                        child: Text(
                          widget.todo.text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          widget.removeTodo(widget.todo);
                        },
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    Color? color;
    switch (priority) {
      case 'Red':
        color = Colors.red[400];
        break;
      case 'Orange':
        color = Colors.orange[300];
        break;
      case 'Blue':
        color = Colors.blue[300];
        break;
    }
    return color ?? Colors.grey; // Use Colors.grey as a fallback color
  }
}

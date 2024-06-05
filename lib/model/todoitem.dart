import 'package:flutter/material.dart';
import 'todoprovider.dart';
import 'todo.dart';
import '../pages/DisplayDialog.dart';
import '../pages/FirstScreen.dart';

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
    return InkWell(
        onTap: onTodoEdit,
        child: ListView(
            shrinkWrap: true,
            // physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                  height: 86,
                  decoration: BoxDecoration(
                    // color: Colors.red,
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
                                    todo.description,
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
                                  backgroundColor:
                                  _getPriorityColor(todo.color),
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
                      ]))
            ]));
  }

  Color _getPriorityColor(String priority) {
    Color? color;
    switch (priority) {
      case 'High':
        color = Colors.red[400];
        break;
      case 'Medium':
        color = Colors.orange[300];
        break;
      case 'Low':
        color = Colors.blue[300];
        break;
    }
    return color ?? Colors.grey; // Use Colors.grey as a fallback color
  }
}
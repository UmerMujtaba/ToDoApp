import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

// final String tableTodo = 'todo';
// final String columnId = '_id';
// final String columnTitle = 'title';
// final String columnDone = 'done';
//


class Todo {
  int? id;
  String title;
  String name;
  bool completed;
  String text;
  String color;
  // bool done;
  Todo({
    this.id,
    required this.title,
    required this.name,
    required this.completed,
    required this.text,
    required this.color,
    // required this.done
  });

  // Map<String, Object?> toMap() {
  //   var map = <String, Object?>{
  //     columnTitle: title,
  //     columnDone: done == true ? 1 : 0
  //   };
  //   if (id != null) {
  //     map[columnId] = id;
  //   }
  //   return map;
  // }
  //
  // Todo.fromMap(Map<String, Object?> map) {
  //   id = map[columnId] as int?;
  //   done = map[columnDone] == 1;
  // }

}

class TodoFields {
  static const String tableName = 'todos';

  static const String id = 'id';
  static const String title = 'title';
  static const String name = 'name';
  static const String completed = 'completed';
  static const String text = 'text';
  static const String color = 'color';

  static const List<String> values = [
    id,
    name,
    title,
    text,
    completed,
    color,
  ];
}

class TodoModel {
  final int? id;
  final String title;
  final String name;
  final bool completed;
  final String text;
  final String color;

  TodoModel({
    this.id,
    required this.title,
    required this.name,
    required this.completed,
    required this.text,
    required this.color,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? name,
    bool? completed,
    String? text,
    String? color,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        name: name ?? this.name,
        completed: completed ?? this.completed,
        text: text ?? this.text,
        color: color ?? this.color,
      );
}

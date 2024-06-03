import 'dart:ui';
import 'package:flutter/material.dart';

class Todo {
  int? id;
  String title;
  String description;
  bool completed;
  String text;
  String color;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.text,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: this.title,
      columndescription: description,
      columnCompleted: completed ? 1 : 0,
      columnText: text,
      columnColor: color, // Store color as an integer
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map)
      : id = map[columnId] as int?,
        title = map[columnTitle] as String,
        description = map[columndescription] as String,
        completed = (map[columnCompleted] as int) == 1,
        text = map[columnText] as String,
        color = map[columnColor] as String // Convert integer to Color
;}

// Constants for column descriptions (replace with your actual column descriptions)
const String columnId = 'id';
const String columnTitle = 'title';
const String columndescription = 'description';
const String columnCompleted = 'completed';
const String columnText = 'text';
const String columnColor = 'color'; // Change to String for column name

// Define your color constants if needed, but in this case, it's not necessary.

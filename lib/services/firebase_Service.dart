import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/todo_Class.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> backupTodosToFirestore(List<Todo> todos) async {
    try {
      CollectionReference todosRef = _firestore.collection('todos');
      todos.forEach((todo) async {
        await todosRef.add(todo.toMap());

      });
      print('Backup successful'); // Check if this message is printed
    } catch (e) {
      print('Error backing up todos: $e'); // Check for any errors
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/model/todo_Class.dart';
import '../model/todo_provider.dart'; // Assuming this is where TodoProvider is defined
import '../services/firebase_service.dart'; // Assuming this is where FirebaseService is defined

// Define the Riverpod provider for TodoStateNotifier
final todoStateNotifierProvider = StateNotifierProvider<TodoStateNotifier, List<Todo>>((ref) {
  return TodoStateNotifier(ref);
});

class TodoStateNotifier extends StateNotifier<List<Todo>> {
  TodoStateNotifier(this.ref): super([]);

  final Ref ref;


  // Method to load todos
  Future<void> loadTodos() async {
    try {
      List<Todo> loadedTodos = (await ref.read(todoProvider).getAllTodos()).cast<Todo>();
      state = loadedTodos;
      print('Fetched ${loadedTodos.length} todos: $loadedTodos');
    } catch (e) {
      print('Error loading todos: $e');
    }
  }

  // Method to backup todos
  Future<void> backupTodos(BuildContext context) async {
    try {
      print('Opening database...');
      await ref.read(todoProvider).open('sample'); // Open the database

      print('Fetching todos...');
      await loadTodos(); // Ensure todos are loaded before backup
      print('Fetched ${state.length} todos: $state');

      print('Backing up todos to Firestore...');
      await ref.read(firebaseServiceProvider).backupTodosToFirestore(state.cast<Todo>());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup successful.')),
      );

      print('Local database closed.');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup failed: $e')),
      );
      print('Backup failed: $e');
    } finally {
      await ref.read(todoProvider).close(); // Always ensure database is closed
    }
  }
}

// Define the Riverpod provider for TodoProvider
final todoProvider = Provider<TodoProvider>((ref) {
  return TodoProvider();
});

// Define the Riverpod provider for FirebaseService
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

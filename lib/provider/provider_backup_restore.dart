import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/model/todo_Class.dart';
import '../model/todo_provider.dart';
import '../services/firebase_service.dart';

// Define the Riverpod provider for TodoStateNotifier
final todoStateNotifierProvider =
    StateNotifierProvider<TodoStateNotifier, List<Todo>>((ref) {
  return TodoStateNotifier(ref);
});

// Define the Riverpod provider for TodoProvider
final todoProvider = Provider<TodoProvider>((ref) {
  return TodoProvider();
});

// Define the Riverpod provider for FirebaseService
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

class TodoStateNotifier extends StateNotifier<List<Todo>> {
  TodoStateNotifier(this.ref) : super([]);

  final StateNotifierProviderRef ref; // Use StateNotifierProviderRef

  // Method to load todos
  Future<void> loadTodos() async {
    try {
      print("provider backup----------------");
      List<Todo> loadedTodos = await ref.read(todoProvider).getAllTodos();
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

      print('Fetching existing todos from Firestore...');
      List<Todo> existingTodos =
          await ref.read(firebaseServiceProvider).getTodosFromFirestore();

      // Create a set of existing todo UIDs for quick lookup
      Set<String> existingTodoUids =
          existingTodos.map((todo) => todo.uid!).toSet();

      // Filter out todos that already exist in Firestore
      List<Todo> newTodos =
          state.where((todo) => !existingTodoUids.contains(todo.uid)).toList();

      print('Backing up ${newTodos.length} new todos to Firestore...');
      // Backup new todos to Firestore
      await ref.read(firebaseServiceProvider).backupTodosToFirestore(newTodos);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup successful.')),
      );

      print('Local database closed.');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup failed: $e')),
      );
      print('Backup failed: $e');
    }
  }

  // Method to restore todos from Firestore
  Future<void> restoreTodos(BuildContext context) async {
    try {
      List<Todo> restoredTodos =
          await ref.read(todoProvider).restoreTodosFromFirestore();
      state = restoredTodos;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restore successful.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Restore failed: $e')),
      );
      print('Restore failed: $e');
    }
  }

  Future<void> deleteAllTodos(BuildContext context) async {
    try {
      print('Deleting all todos from local database...');
      await ref.read(todoProvider).deleteAllTodos();

      print('Deleting all todos from Firestore...');
      await ref.read(firebaseServiceProvider).deleteAllTodosFromFirestore();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All todos deleted successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete todos: $e')),
      );
      print('Failed to delete todos: $e');
    }
  }
}

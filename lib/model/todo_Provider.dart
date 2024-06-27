import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo_Class.dart';

class TodoProvider {
  late Database db;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> open(String path) async {
    try {
      final databasePath = await getDatabasesPath();
      final dbPath = join(databasePath, '$path.db');

      db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE todo (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              uid TEXT NOT NULL,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              completed INTEGER NOT NULL,
              text TEXT NOT NULL,
              color TEXT NOT NULL
            )
          ''');
        },
      );
      print('Database opened successfully from todo provider');
    } catch (e) {
      print('Error opening database: $e');
      throw Exception('Error opening database: $e');
    }
  }

  Future<int> insert(Todo todo) async {
    await _checkDbInitialized();
    int id = await db.insert('todo', todo.toMap());

    // Insert into Firestore
   // await firestore.collection('todos').doc(todo.uid).update(todo.toMap());
    return id;
  }

  Future<List<Todo>> getAllTodos() async {
    if (db == null) {
      throw Exception("Database is not initialized. Call open() before querying.");
    }
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<int> update(Todo todo) async {
    await _checkDbInitialized();
    int result = await db.update('todo', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);

    // Update Firestore
    var snapshots = await firestore
        .collection('todos')
        .where('id', isEqualTo: todo.id)
        .get();
    for (var doc in snapshots.docs) {
      await firestore.collection('todos').doc(doc.id).update(todo.toMap());
    }
    return result;
  }

  Future<int> delete(int id) async {
    return await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }
  Future<void> close() async {
    await _checkDbInitialized();
    await db.close();
  }

  Future<List<Todo>> restoreTodosFromFirestore() async {
    await _checkDbInitialized();
    try {
      // Fetch data from Firestore
      var querySnapshot = await firestore.collection('todos').get();

      // Clear local database
      await db.delete('todo');

      List<Todo> todos = [];

      // Insert fetched data into local database
      querySnapshot.docs.forEach((doc) {
        Todo todo = Todo.fromMap(doc.data() as Map<String, dynamic>);
        todos.add(todo); // Add todo to list
        insert(todo); // Insert into local database
      });

      return todos; // Return the list of todos
    } catch (e) {
      print('Failed to restore todos from Firestore: $e');
      throw Exception('Failed to restore todos from Firestore: $e');
    }
  }

  Future<void> _checkDbInitialized() async {
    if (!db.isOpen) {
      await open('sample'); // Ensure database is open
    }
  }
}

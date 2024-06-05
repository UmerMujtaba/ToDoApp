import 'package:sqflite/sqflite.dart';
import 'TodoClass.dart';
import 'package:path/path.dart';

class TodoProvider {
  late Database db;

  Future<void> open(String path) async {
    final databasePath = await getDatabasesPath();
    final dbPath = join(databasePath, '$path.db');

    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE todo (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            completed INTEGER NOT NULL,
            text TEXT NOT NULL,
            color TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert('todo', todo.toMap());
    return todo;
  }

  Future<List<Todo>> getAllTodos() async {
    try {
      if (db == null) {
        throw Exception("Database is not initialized. Call open() before querying.");
      }
      final List<Map<String, dynamic>> maps = await db!.query('todo');
      return List.generate(maps.length, (i) {
        return Todo.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error fetching todos: $e');
      return [];
    }
  }




  Future<int> update(Todo todo) async {
    return await db
        .update('todo', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async {
    return await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async => db.close();
}

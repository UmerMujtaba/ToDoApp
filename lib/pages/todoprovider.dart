// todoprovider.dart
import 'package:sqflite/sqflite.dart';
import 'todo.dart';

class TodoProvider {
  late Database db;
  bool _isOpen = false; // Add a boolean flag to track if the database is opened

  bool get isOpen => _isOpen;


  Future open(String path) async {
    try {
      db = await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute('''
          create table $tableTodo ( 
            $columnId integer primary key autoincrement, 
            $columnTitle text not null,
            $columnDescription text not null,
            $columnCompleted text not null,
            $columnText text not null,
            $columnColor text not null)
        ''');
      });
      _isOpen = true;
      print('Database opened');
    } catch (e) {
      print('Error opening database: $e');
      // Handle the error, e.g., show an error message or throw an exception
      throw e;
    }
  }

  Future<Todo> insert(Todo todo) async {
    try {
      todo.id = await db.insert(
        tableTodo,
        todo.toMap(), // Ensure that the "description" field is included in the map
      );
      print('Data inserted successfully');
      return todo;
    } catch (e) {
      print('Error inserting data: $e');
      throw e; // Rethrow the exception to handle it in the calling code if needed
    }
  }



  Future<Todo?> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [
          columnId,
          columnTitle,
          columnDescription,
          columnText,
          columnCompleted,
          columnColor
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<List<Todo>> getAllTodos() async {
    List<Map<String, dynamic>> maps = await db.query(tableTodo);
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }


  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}

// Constants for table and column names
const String tableTodo = 'todo';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDescription = 'description';
const String columnText = 'text';
const String columnCompleted='completed';
const String columnColor='color';


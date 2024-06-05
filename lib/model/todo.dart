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
      columnTitle: title,
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

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int?,
      // Ensure 'id' is cast to int?
      title: map['title'] as String,
      description: map['description'] as String,
      completed: map['completed'] == 1,
      // Convert to bool
      text: map['text'] as String,
      color: map['color'] as String,
    );
  }
}

// Constants for column descriptions (replace with your actual column descriptions)
const String columnId = 'id';
const String columnTitle = 'title';
const String columndescription = 'description';
const String columnCompleted = 'completed';
const String columnText = 'text';
const String columnColor = 'color'; // Change to String for column name

// Define your color constants if needed, but in this case, it's not necessary.

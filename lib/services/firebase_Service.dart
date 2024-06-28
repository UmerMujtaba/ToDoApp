import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/todo_Class.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Todo>> getTodosFromFirestore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('todos').get();
    return querySnapshot.docs.map((doc) => Todo.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> backupTodosToFirestore(List<Todo> todos) async {
    for (Todo todo in todos) {
      await _firestore.collection('todos').doc(todo.uid).set(todo.toMap());
    }
  }

  Future<void> deleteAllTodosFromFirestore() async {
    QuerySnapshot querySnapshot = await _firestore.collection('todos').get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}

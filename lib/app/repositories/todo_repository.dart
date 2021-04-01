import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:todo_list_firebase/app/models/todo_model.dart';
import 'package:todo_list_firebase/app/repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  final Firestore _firestore;

  TodoRepository(
    this._firestore,
  );

  @override
  Stream<List<TodoModel>> getAllTodo() {
    var myTodos =
        _firestore.collection('todos').orderBy('position').snapshots();

    return myTodos.map(
      (query) {
        return query.documents
            .map((doc) => TodoModel.fromDocument(doc))
            .toList();
      },
    );
  }
}

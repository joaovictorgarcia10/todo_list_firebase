import 'package:todo_list_firebase/app/models/todo_model.dart';

abstract class ITodoRepository {
  Stream<List<TodoModel>> getAllTodo() {}
}

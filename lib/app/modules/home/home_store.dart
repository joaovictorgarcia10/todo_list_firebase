import 'package:mobx/mobx.dart';
import 'package:todo_list_firebase/app/models/todo_model.dart';

import 'package:todo_list_firebase/app/repositories/todo_repository_interface.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ITodoRepository repository;

  @observable
  ObservableStream<List<TodoModel>> todoList;

  HomeStoreBase(this.repository) {
    getList(); // passando mo constructor para ser chamado semore ao iniciar
  }

  @action
  getList() {
    Future.delayed(Duration(seconds: 3));
    todoList = repository.getAllTodo().asObservable();
  }
}

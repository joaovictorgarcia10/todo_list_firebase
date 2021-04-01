import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_firebase/app/repositories/todo_repository.dart';
import 'package:todo_list_firebase/app/repositories/todo_repository_interface.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore(i.get())),
    Bind<ITodoRepository>((i) => TodoRepository(Firestore.instance)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}

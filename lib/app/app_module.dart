import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_firebase/app/modules/home/home_store.dart';
import 'package:todo_list_firebase/app/repositories/todo_repository.dart';
import 'package:todo_list_firebase/app/repositories/todo_repository_interface.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}

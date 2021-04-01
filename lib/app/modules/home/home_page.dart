import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_firebase/app/models/todo_model.dart';
import 'package:todo_list_firebase/app/modules/home/home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({this.title = "Home"});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ToDo List'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.blue[900],
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  color: Colors.transparent,
                  padding: EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Atividades',
                      style: TextStyle(
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2 + 150,
                  padding: EdgeInsets.only(top: 30.0, right: 2.0, left: 1.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Observer(
                    builder: (_) {
                      // Todo List Has Error
                      if (controller.todoList.hasError) {
                        return Center(
                          child: TextButton(
                            onPressed: controller.getList(),
                            child: Text("Tentar Novamente"),
                          ),
                        );
                      }

                      // Todo List Null
                      if (controller.todoList.data == null) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      // Todo List Ok
                      List<TodoModel> list = controller.todoList.data;
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (_, idx) {
                          var model = list[idx];

                          return ListTile(
                            onTap: () {
                              _showDialog(model);
                            },
                            //
                            title: Text(
                              model.title,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            //
                            leading: IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                model.delete();
                              },
                            ),
                            //
                            trailing: Checkbox(
                              value: model.check,
                              onChanged: (check) {
                                model.check = check;
                                model.save();
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ),
    );
  }

  Future _showDialog([TodoModel model]) async {
    model ??= TodoModel();

    return await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            model.title.isEmpty ? "Adicionar Atividade" : "Editar Atividade",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextFormField(
            initialValue: model.title,
            autofocus: true,
            onChanged: (value) {
              model.title = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Digite aqui",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancelar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                model.save();
                Navigator.pop(context);
              },
              child: Text(
                'Salvar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }
}

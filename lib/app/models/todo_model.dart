import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String title;
  bool check;
  DocumentReference documentReference;

  TodoModel({
    this.title = "",
    this.check = false,
    this.documentReference,
  });

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
      title: doc['title'],
      check: doc['check'],
      documentReference: doc.reference,
    );
  }

//

  Future save() async {
    int total = (await Firestore.instance.collection("todos").getDocuments())
        .documents
        .length;

    if (documentReference == null) {
      //Adicionar Novo ToDo
      documentReference = await Firestore.instance.collection("todos").add({
        'title': title,
        'check': check,
        'position': total,
      });
    } else {
      // Atualizar ToDO
      documentReference.updateData({
        'title': title,
        'check': check,
      });
    }
  }

//
  delete() {
    documentReference.delete();
  }
}

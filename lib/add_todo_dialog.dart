import 'package:flutter/material.dart';
import 'package:simple_todo_app_sqlite/database_helper.dart';
import 'package:simple_todo_app_sqlite/todo.dart';

class AddTodoDialog {
  final titleTEXT = TextEditingController();
  final releaseDateTEXT = TextEditingController();
  Todo? todo;

  Widget buildAboutDialog(
      BuildContext context, myHomePageState, bool isEdit, Todo? todo) {
    if (todo != null) {
      this.todo = todo;
      titleTEXT.text = todo.title;
      releaseDateTEXT.text = todo.releaseDate;
    }
    return AlertDialog(
      title: Text(isEdit ? "Edit Todo" : "Add Todo"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getTextField("Enter title", titleTEXT),
            getTextField("Enter date DD-MM-YYYY", releaseDateTEXT),
            TextButton(
              child: isEdit ? const Text("Edit") : const Text("Add"),
              onPressed: () {
                addUpdateRecord(isEdit);
                myHomePageState.displayRecord();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginButton = Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(hintText: inputBoxName),
      ),
    );
    return loginButton;
  }

  Future addUpdateRecord(bool isEdit) async {
    var db = DatabaseHelper();
    var todo = Todo(
      title: titleTEXT.text,
      releaseDate: releaseDateTEXT.text,
    );
    if (isEdit) {
      todo.setTodoId(this.todo!.id);
      await db.update(todo);
    } else {
      await db.saveTodo(todo);
    }
  }
}

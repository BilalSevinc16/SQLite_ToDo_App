import 'package:simple_todo_app_sqlite/database_helper.dart';
import 'package:simple_todo_app_sqlite/todo.dart';

abstract class TodoContact {
  void screenUpdate();
}

class TodoPresenter {
  final TodoContact _view;
  var db = DatabaseHelper();

  TodoPresenter(this._view);

  delete(Todo todo) {
    var db = DatabaseHelper();
    db.deleteTodos(todo);
    updateScreen();
  }

  Future<List<Todo>> getTodos() {
    return db.getTodos();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}

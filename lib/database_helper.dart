import 'dart:async';
import 'dart:io' as io;
import 'package:simple_todo_app_sqlite/todo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "todoapp.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Todo(id INTEGER PRIMARY KEY, title TEXT, release_date TEXT)");
  }

  Future<int> saveTodo(Todo todo) async {
    var dbClient = await db;
    int res = await dbClient!.insert("Todo", todo.toMap());
    return res;
  }

  Future<List<Todo>> getTodos() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery("SELECT * FROM Todo");
    List<Todo> todos = [];
    for (var i = 0; i < list.length; i++) {
      var todo =
          Todo(title: list[i]["title"], releaseDate: list[i]["release_date"]);
      todo.setTodoId(list[i]["id"]);
      todos.add(todo);
    }
    return todos;
  }

  Future<int> deleteTodos(Todo todo) async {
    var dbClient = await db;
    int res =
        await dbClient!.rawDelete("DELETE FROM Todo WHERE id = ?", [todo.id]);
    return res;
  }

  Future<bool> update(Todo todo) async {
    var dbClient = await db;
    int res = await dbClient!.update("Todo", todo.toMap(),
        where: "id = ?", whereArgs: <int>[todo.id]);
    return res > 0 ? true : false;
  }
}

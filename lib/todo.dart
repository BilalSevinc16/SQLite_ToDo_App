class Todo {
  late int id;
  late String title;
  late String releaseDate;

  Todo({
    required this.title,
    required this.releaseDate,
  });

  Todo.map(dynamic obj) {
    title = obj["title"];
    releaseDate = obj["release_date"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["release_date"] = releaseDate;
    return map;
  }

  void setTodoId(int id) {
    this.id = id;
  }
}

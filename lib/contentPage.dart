import 'package:flutter/material.dart';
import 'package:simple_todo_app_sqlite/add_todo_dialog.dart';
import 'package:simple_todo_app_sqlite/todo.dart';
import 'package:simple_todo_app_sqlite/todo_presenter.dart';

class ContentPage extends StatelessWidget {
  List<Todo> todoList;
  TodoPresenter todoPresenter;

  ContentPage(this.todoList, this.todoPresenter, {super.key});

  displayRecord() {
    todoPresenter.updateScreen();
  }

  edit(Todo todo, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddTodoDialog().buildAboutDialog(
        context,
        this,
        true,
        todo,
      ),
    );
    todoPresenter.updateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: todoList == null ? 0 : todoList.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade400,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width:
                        MediaQuery.of(context).size.width - 56 - 14 - 16 - 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todoList[index].title,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          todoList[index].releaseDate,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          edit(todoList[index], context);
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          todoPresenter.delete(todoList[index]);
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

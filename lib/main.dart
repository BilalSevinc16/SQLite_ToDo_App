import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_todo_app_sqlite/add_todo_dialog.dart';
import 'package:simple_todo_app_sqlite/contentPage.dart';
import 'package:simple_todo_app_sqlite/todo.dart';
import 'package:simple_todo_app_sqlite/todo_presenter.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TodoApp",
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements TodoContact {
  TodoPresenter? todoPresenter;

  @override
  void initState() {
    super.initState();
    todoPresenter = TodoPresenter(this);
  }

  displayRecord() {
    setState(() {});
  }

  Future _openAddUpdateTodoDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddTodoDialog().buildAboutDialog(
        context,
        this,
        false,
        null,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 148,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Todo App",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: width - 56 - 16,
                    top: 92,
                    child: FloatingActionButton(
                      elevation: 0,
                      onPressed: () {
                        _openAddUpdateTodoDialog();
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  148 -
                  (Platform.isIOS ? 78 : 24),
              child: FutureBuilder<List<Todo>>(
                future: todoPresenter!.getTodos(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.hasError);
                  var data = snapshot.data;
                  return snapshot.hasData
                      ? ContentPage(data!, todoPresenter!)
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}



import 'package:flutter/material.dart';
import 'package:todo_app/pages/todo_pages/create_todo.dart';
import 'package:todo_app/pages/todo_pages/search_and_filter_todo.dart';
import 'package:todo_app/pages/todo_pages/show_todos.dart';
import 'todo_header.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                TodoHeader(),
                CreateTodo(),
                SizedBox(
                  height: 20,
                ),
                SearchAndFilter(),
                ShowTodos()
              ],
            )),
      ),
    ));
  }
}

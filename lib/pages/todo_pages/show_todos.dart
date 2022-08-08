// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/cubits/cubits.dart';
import 'package:todo_app/models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilterdTodosCubit>().state.filterdTodos;
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) => Dismissible(
              key: ValueKey(todos[index].id),
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              onDismissed: (_) {
                context.read<TodoListCubit>().removeTodo(todos[index].id);
              },
              confirmDismiss: (_) {
                return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Are you Sure ?'),
                          content: Text('Do you really want to delete ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ));
              },
              child: TodoItem(
                todoItem: todos[index],
              ),
            ),
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
        itemCount: todos.length);
  }

  Widget showBackground(int direction) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final TodoModel todoItem;
  const TodoItem({
    Key? key,
    required this.todoItem,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textController.text = widget.todoItem.desc;
              return StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  title: Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        errorText: _error ? 'Value cannot be empty' : null),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _error = textController.text.isEmpty ? true : false;
                        });
                        if (!_error) {
                          context.read<TodoListCubit>().editTodo(
                              widget.todoItem.id, textController.text);
                          Navigator.pop(context);
                        }
                      },
                      child: Text('EDIT'),
                    ),
                  ],
                ),
              );
            });
      },
      leading: Checkbox(
          onChanged: (bool? completed) {
            context.read<TodoListCubit>().toggleTodo(widget.todoItem.id);
          },
          value: widget.todoItem.completed),
      title: Text(widget.todoItem.desc),
    );
  }
}

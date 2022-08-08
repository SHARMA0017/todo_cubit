import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc) {
    final TodoModel todo = TodoModel(desc: todoDesc);
    final newTodos = [...state.todos, todo];
    print(todo);
    emit(state.copyWith(todos: newTodos));
  }

  void editTodo(String id, String desc) {
    final newTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return TodoModel(id: id, desc: desc, completed: todo.completed);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return TodoModel(id: id, desc: todo.desc, completed: !todo.completed);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void removeTodo(String id) {
    final newTodos = state.todos.where((todo) => todo.id != id).toList();
    emit(state.copyWith(todos: newTodos));
  }
}

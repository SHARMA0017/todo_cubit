// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_app/models/todo_model.dart';

part 'filterd_todos_state.dart';

class FilterdTodosCubit extends Cubit<FilterdTodosState> {
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoListSubscription;
  final List<TodoModel> initialTodos;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  FilterdTodosCubit({
    required this.initialTodos,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
  }) : super(FilterdTodosState(filterdTodos: initialTodos)) {
    todoFilterSubscription = todoFilterCubit.stream.listen((event) {
      setFilteredTodos();
    });
    todoSearchSubscription = todoSearchCubit.stream.listen((event) {
      setFilteredTodos();
    });
    todoListSubscription = todoListCubit.stream.listen((event) {
      setFilteredTodos();
    });
  }
  void setFilteredTodos() {
    List<TodoModel> _filteredTodos;
    switch (todoFilterCubit.state.filter) {
      case Filter.Active:
        _filteredTodos =
            todoListCubit.state.todos.where((todo) => !todo.completed).toList();
        break;
      case Filter.Completed:
        _filteredTodos =
            todoListCubit.state.todos.where((todo) => todo.completed).toList();
        break;
      case Filter.All:
      default:
        _filteredTodos = todoListCubit.state.todos;
        break;
    }
    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((TodoModel todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }
    emit(state.copyWith(filterdTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}

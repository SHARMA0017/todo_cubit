// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  late final StreamSubscription todoStreamSubscription;
  final TodoListCubit todoListCubit;
  final int initialActiveTodoCount;
  ActiveTodoCountCubit(
      {required this.todoListCubit, required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoStreamSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      final newTodoActiveCount = todoListState.todos
          .where((todo) => todo.completed != true)
          .toList()
          .length;
      emit(state.copyWith(activeTodoCount: newTodoActiveCount));
    });
  }
  @override
  Future<void> close() {
    todoStreamSubscription.cancel();
    return super.close();
  }
}

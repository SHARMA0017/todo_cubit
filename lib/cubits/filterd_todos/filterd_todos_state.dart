// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filterd_todos_cubit.dart';

class FilterdTodosState extends Equatable {
  final List<TodoModel> filterdTodos;
  FilterdTodosState({
    required this.filterdTodos,
  });
  factory FilterdTodosState.initial() {
    return FilterdTodosState(filterdTodos: []);
  }

  @override
  List<Object> get props => [filterdTodos];

  @override
  bool get stringify => true;

  FilterdTodosState copyWith({
    List<TodoModel>? filterdTodos,
  }) {
    return FilterdTodosState(
      filterdTodos: filterdTodos ?? this.filterdTodos,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Filter {
  All,
  Active,
  Completed,
}

Uuid uuid = Uuid();

class TodoModel extends Equatable {
  final String id;
  final String desc;
  final bool completed;
  TodoModel({
    String? id,
    required this.desc,
    this.completed = false,
  }) : this.id = id ?? uuid.v4();

  @override
  List<Object> get props => [id, desc, completed];

  @override
  bool get stringify => true;
}

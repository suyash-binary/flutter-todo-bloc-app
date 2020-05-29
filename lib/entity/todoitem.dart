import 'package:equatable/equatable.dart';

class TodoItem extends Equatable {
  final String text;
  final bool done;

  TodoItem({this.text, this.done});

  @override
  List<Object> get props => [text, done];
}

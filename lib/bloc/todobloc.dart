import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc_todo_app/entity/todoitem.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoAddEvent extends TodoEvent {
  final TodoItem todoItem;

  TodoAddEvent({this.todoItem});

  @override
  List<Object> get props => [todoItem];
}

class TodoTickEvent extends TodoEvent {
  final int index;

  TodoTickEvent({@required this.index});

  @override
  List<Object> get props => [index];
}

class TodoState extends Equatable {
  final List<TodoItem> todoItems;

  TodoState({this.todoItems = const []});

  @override
  List<Object> get props => [todoItems];

  @override
  String toString() => "Items: ${todoItems.length}";
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  @override
  TodoState get initialState => TodoState();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoAddEvent) {
      final List<TodoItem> newtodoItems = List.from(state.todoItems)
        ..add(TodoItem(text: event.todoItem.text, done: event.todoItem.done));
      yield TodoState(todoItems: newtodoItems);
    } 
    
    if (event is TodoTickEvent) {
      List<TodoItem> newtodoItems = List.from(state.todoItems);
      newtodoItems[event.index] = TodoItem(text: state.todoItems[event.index].text, done:!state.todoItems[event.index].done);
      yield TodoState(todoItems: newtodoItems);
    }
  }
}
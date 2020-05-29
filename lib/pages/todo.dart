import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/bloc/todobloc.dart';
import 'package:bloc_todo_app/entity/todoitem.dart';
import 'package:bloc_todo_app/widgets/addTodoDialog.dart';

class TodoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final TodoBloc todoBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Todo App"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: state.todoItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                    Expanded(
                      child: Text(
                        '${state.todoItems[index].text}',
                        style: TextStyle(
                            decoration: state.todoItems[index].done
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                    Checkbox(
                        value: state.todoItems[index].done,
                        onChanged: (newvalue) {
                          todoBloc.add(TodoTickEvent(index: index));
                        })
                  ])));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          String todo = await ShowAddTodoDialog(context);
          if (todo.trim().length > 0) {
            todoBloc
                .add(TodoAddEvent(todoItem: TodoItem(text: todo, done: false)));
          }
        },
      ),
    );
  }
}

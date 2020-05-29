import 'package:flutter/material.dart';

Future<String> ShowAddTodoDialog(BuildContext context) async {
    String todo = '';
    return showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("What to do?"),
            content: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    todo = value;
                  },
                ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop(todo);
                },
              ),
            ],
          );
        });
  }
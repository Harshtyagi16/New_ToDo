import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/todo.dart';
import 'package:intl/intl.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: const Color.fromARGB(255, 220, 218, 193),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Column(children: [
          Text(
            todo.todoText,
            style: TextStyle(
              color: Colors.black,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          Text(todo.date.toString())
        ]), // ignore: prefer_const_constructors

        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.red,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}

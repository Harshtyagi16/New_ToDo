import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/todo_item.dart';
import 'package:intl/intl.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Methods methods = Methods();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];
  bool sort = false;

  @override
  void initState() {
    _foundToDo = methods.toDoList;
    super.initState();
  }

  Widget build(BuildContext context) {
    // ignore: dead_code
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        // ignore: prefer_const_constructors
        title: Center(
            child: const Text(
          'Reminder App',
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: Container(
        child: Column(
          children: [
            SortByDate(),
            SearchBox(),
            Expanded(
              child: ListView.builder(
                  itemCount: _foundToDo.length,
                  itemBuilder: (BuildContext context, int index) {
                    final meth = sort ? methods.sortList() : methods.toDoList;
                    return ToDoItem(
                      todo: meth[index],
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: _deleteToDoItem,
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      )),
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(int id) {
    setState(() {
      // ignore: unrelated_type_equality_checks
      methods.toDoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      methods.toDoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toInt(),
          todoText: toDo,
          date: DateTime.now()));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = methods.toDoList;
    } else {
      results = methods.toDoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // ignore: prefer_const_constructors
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }

  Widget SortByDate() {
    return Container(
      child: IconButton(
        color: Colors.red,
        iconSize: 28,
        icon: const Icon(Icons.sort),
        onPressed: () {
          setState(() {
            sort = !sort;
          });
        },
      ),
    );
  }
}

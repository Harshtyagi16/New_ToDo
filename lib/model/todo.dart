class ToDo {
  int? id;
  String todoText;
  bool isDone;
  DateTime date;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    required this.date,
  });
}

class Methods {
  List<ToDo> toDoList = [
    ToDo(id: 1, todoText: "Morning", isDone: true, date: DateTime.now()),
  ];

  //  List<ToDo> todoList() {
  //   return [

  //   ];

  void addTodDo(int id, String toDo, bool isDone, DateTime date) {
    return toDoList.add(ToDo(id: id, todoText: toDo, date: date));
  }

  List<ToDo> sortList() {
    return toDoList.reversed.toList();
  }
}

import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // reference the box
  final _myBox = Hive.box("myBox");

  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Make To-Do Application", true]
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}

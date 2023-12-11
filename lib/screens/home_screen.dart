import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/components/dialog_box.dart';
import 'package:to_do_app/components/to_do_container.dart';
import 'package:to_do_app/data/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _myBox = Hive.box("myBox");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  final _textController = TextEditingController();
  void onChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void onFloatingButton() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _textController,
        onSave: addNewTask,
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void addNewTask() {
    setState(() {
      db.toDoList.add([_textController.text, false]);
      _textController.clear();
    });
    db.updateDataBase();
    Navigator.pop(context);
  }

  void deleteTask(int index) {
    print("123123");
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To-Do Application")),
      backgroundColor: Colors.grey[700],
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
            child: ToDoContainer(
              task: db.toDoList[index][0],
              isCompleted: db.toDoList[index][1],
              onChanged: (value) => onChanged(value, index),
              deleteTask: (context) => deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: onFloatingButton,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}

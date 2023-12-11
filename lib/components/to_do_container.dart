import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoContainer extends StatelessWidget {
  final String task;
  bool isCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  ToDoContainer(
      {super.key,
      required this.task,
      required this.isCompleted,
      required this.onChanged,
      required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete,
            backgroundColor: Colors.white70,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey),
        child: Row(
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: onChanged,
              activeColor: Colors.black,
              shape: const CircleBorder(side: BorderSide(width: 10)),
            ),
            Text(
              task,
              style: TextStyle(
                decoration: isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}

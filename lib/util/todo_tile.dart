import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
      child: Slidable(
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: const Color.fromRGBO(234, 140, 128, 1),
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.cyan[300],
            ),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  value: taskCompleted,
                  onChanged: onChanged,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                    color: Colors.black,
                    decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

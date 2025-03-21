import "package:flutter/material.dart";

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool taskStatus;
  Function(bool?)? onChanged;

  TodoTile(
      {super.key,
      required this.taskname,
      required this.taskStatus,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: ListTile(
        title: Text(
          taskname,
          style: taskStatus
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : TextStyle(decoration: TextDecoration.none),
        ),
        leading: Checkbox(
          value: taskStatus,
          onChanged: onChanged,
          activeColor: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.amber[400], borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 12),
    );
  }
}

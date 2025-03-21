import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CupertinoColors.systemYellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type Your Name",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: MyButton(
                    text: "Save",
                    onPressed: onSave,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: MyButton(
                    text: "Cancel",
                    onPressed: onCancel,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

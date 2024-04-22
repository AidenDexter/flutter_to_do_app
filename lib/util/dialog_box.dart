// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox._({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.controller,
  });

  static void show({
    required BuildContext context,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    required TextEditingController controller,
  }) =>
      showDialog(
          context: context,
          builder: (context) {
            return DialogBox._(
              onSave: onSave,
              onCancel: onCancel,
              controller: controller,
            );
          });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.cyan[300],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'new task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  buttonName: 'Save',
                  onPressed: onSave,
                ),
                const SizedBox(
                  width: 8,
                ),
                MyButton(
                  buttonName: 'Cancel',
                  onPressed: onCancel,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

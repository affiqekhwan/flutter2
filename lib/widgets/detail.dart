import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> todoItem;

  DetailPage({required this.todoItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(todoItem["name"]),
            Text(todoItem["desc"]),
            Text(todoItem["place"]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context, {"action": 1, "object": todoItem});
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context, {"action": 2, "object": todoItem});
                  },
                  icon: const Icon(Icons.check),
                  label: !todoItem["completed"] ? const Text("Mark as completed") : const Text("Incomplete Item"))

              ],
            ),
          ],
        ),
      ),
    );
  }
}




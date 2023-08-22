import 'dart:convert';
import 'package:flutter/material.dart';
import 'add.dart';
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var todos = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var saveItem = prefs.getString("todos");
    if (saveItem != null) {
      setState(() {
        todos = jsonDecode(saveItem);
      });
    }
  }

  Future<void> updateData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("todos", jsonEncode(todos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do App"),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: () async {
              var newItem = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPage()),
              );
              if (newItem != null) {
                setState(() {
                  todos.add(newItem);
                });
                await updateData();
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading:
                  todos[index]["completed"] ? const Icon(Icons.check) : const SizedBox(),
              title: Text(todos[index]["name"]),
              subtitle: Text(todos[index]["place"]),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                var data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(todoItem: todos[index]),
                  ),
                );
                if (data != null) {
                  if (data["action"] == 1) {
                    setState(() {
                      todos.remove(todos[index]);
                    });
                    await updateData();
                  } else {
                    setState(() {
                      todos[index]["completed"] = !todos[index]["completed"];
                    });
                    await updateData();
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}

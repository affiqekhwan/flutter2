import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  var nameEdittingController = TextEditingController();
  var descEdittingController = TextEditingController();
  var placeEdittingController = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Page"), backgroundColor: Colors.lightBlue,),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(hintText: "Enter Item Name"),
              controller: nameEdittingController,),
              TextField(
                decoration: const InputDecoration(hintText: "Enter Item Description"),
              controller: descEdittingController,),
              TextField(
                decoration: const InputDecoration(hintText: "Enter Item Place"),
              controller: placeEdittingController,),
              ElevatedButton(onPressed: () {
                print(nameEdittingController.text);
                print(descEdittingController.text);
                print(placeEdittingController.text);

                var newItem = {

                  "name": nameEdittingController.text,
                  "desc": descEdittingController.text,
                  "place": placeEdittingController.text,
                  "completed": false
                };
                Navigator.pop(context, newItem);
              },
                  child: const Text(" Add New Item"))
            ],
          ),
        )
    );
  }
}
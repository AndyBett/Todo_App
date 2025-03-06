import 'package:flutter/material.dart';

class Addtodo extends StatefulWidget {
  const Addtodo({super.key});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Add todo:"),
      TextField(
        controller: todoText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5),
          hintText: "Write your todo here ...",
        ),
      ),
      const SizedBox(),
      const SizedBox(),
      ElevatedButton(
          onPressed: () {
            print(todoText.text);
            todoText.text = "";
          },
          child: const Text("Add"))
    ]);
  }
}

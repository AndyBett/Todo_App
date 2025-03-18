import 'package:flutter/material.dart';

class TodolistBuilder extends StatefulWidget {
  List<String> todoList;
  void Function() updateLocalData;
  TodolistBuilder(
      {super.key, required this.todoList, required this.updateLocalData});

  @override
  State<TodolistBuilder> createState() => _TodolistBuilderState();
}

class _TodolistBuilderState extends State<TodolistBuilder> {
//This function gets triggered when list item is clicked!
  void onItemClicked({required int index}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              width: 500,
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.todoList.removeAt(index);
                    });
                    widget.updateLocalData;
                    Navigator.pop(context);
                  },
                  child: Text("Mark as done!")));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.todoList.length,
        itemBuilder: (BuildContext Context, int index) {
          return ListTile(
            onTap: () {
              onItemClicked(index: index);
            },
            title: Text(widget.todoList[index]),
          );
        });
  }
}

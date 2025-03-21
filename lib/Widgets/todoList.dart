import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class TodoListBuilder extends StatefulWidget {
  List<String> todoList;
  void Function() updateLocalData;
  TodoListBuilder({
    super.key,
    required this.todoList,
    required this.updateLocalData,
  });

  @override
  State<TodoListBuilder> createState() => _TodoListBuilderState();
}

class _TodoListBuilderState extends State<TodoListBuilder> {
  // This function gets triggered when list item is clicked!
  void onItemClicked({required int index}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.todoList.removeAt(index);
                    });
                    widget.updateLocalData();
                    Navigator.pop(context);
                  },
                  child: const Text("Mark as Done!")));
        });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? const Center(child: Text("No items on your todo list"))
        : ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                    color: Colors.green,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.check),
                        ),
                      ],
                    )),
                onDismissed: (direction) {
                  setState(() {
                    widget.todoList.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  onTap: () {
                    onItemClicked(index: index);
                  },
                  title: Text(widget.todoList[index]),
                ),
              );
            });
  }
}

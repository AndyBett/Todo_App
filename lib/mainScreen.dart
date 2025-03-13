import 'package:flutter/material.dart';
import 'package:todoapp/addTodo.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<String> todoList = ["Drink water", "Make Dinner", "Sleep"];

  void addTodo({required String todoText}) {
    setState(() {
      todoList.insert(0, todoText);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Todo App'),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: 250,
                          child: Addtodo(
                            addTodo: addTodo,
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext Context, int index) {
              return ListTile(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            width: 500,
                            padding: EdgeInsets.all(20),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    todoList.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text("Mark as done!")));
                      });
                },
                title: Text(todoList[index]),
              );
            }));
  }
}

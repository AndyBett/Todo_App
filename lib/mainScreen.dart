import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/Widgets/todoList.dart';
import 'package:todoapp/addTodo.dart';

import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Already exists"),
              content: const Text("This todo data already exists."),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"))
              ],
            );
          });

      return;
    }

    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = prefs.getStringList("todoList") ?? [];
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    // Super.initState
    super.initState();
  }

  void showAddTodoBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              child: AddTodo(addTodo: addTodo),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blueGrey[900],
          onPressed: showAddTodoBottomSheet,
          child: Icon(Icons.add, color: Colors.white)),
      drawer: Drawer(
          child: Column(
        children: [
          Container(
            color: Colors.blueGrey[900],
            height: 200,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Todo App",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
              onTap: () {
                launchUrl(Uri.parse("https://www.youtube.com"));
              },
              leading: const Icon(Icons.person),
              title: const Text("About Me",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Contact me",
                  style: TextStyle(fontWeight: FontWeight.bold)))
        ],
      )),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo App"),
      ),
      body: TodoListBuilder(
        todoList: todoList,
        updateLocalData: updateLocalData,
      ),
    );
  }
}

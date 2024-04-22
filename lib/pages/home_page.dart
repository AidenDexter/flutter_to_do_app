import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    if (_controller.text != '') {
      setState(() {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      });
    }

    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    DialogBox.show(
      context: context,
      onSave: saveNewTask,
      onCancel: () => Navigator.of(context).pop(),
      controller: _controller,
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        backgroundColor: Colors.cyan[200],
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(
                    value,
                    index,
                  ),
              deleteFunction: (context) => deleteTask(index));
        },
      ),
    );
  }
}

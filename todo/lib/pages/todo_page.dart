import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils/dialog.dart';
import 'package:todo/utils/todo_tile.dart';
// import 'package:todo/utils/todo_tile.dart';

void main() {
  runApp(const TodoPage());
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _myBox = Hive.box("mybox");

  TextEditingController _mycontroller = TextEditingController();
  TodoDatabase db = TodoDatabase();
  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _mycontroller,
            onSave: SaveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void onChange(bool? value, int index) {
    setState(() {
      db.Tasks[index][1] = !db.Tasks[index][1];
    });
    // db.Tasks.removeAt(index);
    db.update_data();
  }

  void onDelete(int index) {
    if (index >= 0 && index < db.Tasks.length) {
      // Check index range
      setState(() {
        db.Tasks.removeAt(index);
      });
    } else {
      print("Error: Invalid index $index, Tasks length: ${db.Tasks.length}");
    }
  }

  void SaveNewTask() {
    setState(() {
      db.Tasks.add([_mycontroller.text, false]);
      _mycontroller.clear();
    });
    Navigator.of(context).pop();
    db.update_data();
  }

  @override
  void initState() {
    if (_myBox.get("TODOLIST") != null) {
      db.load_data();
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(child: Text("TO DO")),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView.builder(
            itemCount: db.Tasks.length,
            itemBuilder: (context, index) {
              return TodoTile(
                  taskname: db.Tasks[index][0],
                  taskStatus: db.Tasks[index][1],
                  onChanged: (value) => onChange(value, index),
                  onDelete: () => onDelete(index));
            },

            // children: [
            //   // TextField(
            //   //   controller: _mycontroller,
            //   //   decoration: InputDecoration(
            //   //       border: OutlineInputBorder(), hintText: "Type Your Name"),
            //   // ),
            //   // Padding(
            //   //   padding: const EdgeInsets.all(8.0),
            //   //   child: ElevatedButton(onPressed: () {}, child: Text("Tap")),
            //   // )
            //   TodoTile(
            //     taskname: "Task1",
            //     taskStatus: false,
            //     onChanged: (p0) {},
            //   ),
            //   TodoTile(
            //     taskname: "Task2",
            //     taskStatus: false,
            //     onChanged: (p0) {},
            //   ),
            //   TodoTile(
            //     taskname: "Task3",
            //     taskStatus: false,
            //     onChanged: (p0) {},
            //   ),
            // ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List Tasks = [];
  final _myBox = Hive.box("mybox");

  void load_data() {
    Tasks = _myBox.get("TODOLIST");
  }

  void update_data() {
    _myBox.put("TODOLIST", Tasks);
  }
}

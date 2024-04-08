import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_clone/model/student_model.dart';

class TodoController {
  static List todoKeyList = [];
  static var box = Hive.box<TaskModel>('task');

  static void initData() {
    todoKeyList = box.keys.toList();
  }

  static Future<void> addData(TaskModel item) async {
    await box.add(item);
    initData();
  }

  static TaskModel? getData(var key) {
    return box.get(key);
  }

  static Future<void> deleteData(var key) async {
    await box.delete(key);
    initData();
  }

  static Future<void> updateData(var key, TaskModel item) async {
    await box.put(key, item);
    initData();
  }
}

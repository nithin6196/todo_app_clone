import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  String text;
  @HiveField(1)
  bool isCompleted;
  TaskModel({this.isCompleted = false, required this.text});
}

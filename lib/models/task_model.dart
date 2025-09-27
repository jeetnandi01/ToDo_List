import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String priority;

  @HiveField(4)
  bool isDone;

  @HiveField(5)
  String repeat;

  @HiveField(6)
  String category;

  @HiveField(7)
  int? startHour;
  @HiveField(8)
  int? startMinute;

  @HiveField(9)
  int? endHour;
  @HiveField(10)
  int? endMinute;

  @HiveField(11)
  bool isPinned;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    this.isDone = false,
    this.repeat = 'None',
    this.category = 'General',
    this.startHour,
    this.startMinute,
    this.endHour,
    this.endMinute,
    this.isPinned = false,
  });
}

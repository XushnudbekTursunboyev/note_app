

import 'package:hive/hive.dart';

class NotesModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String date;
  @HiveField(4)
  bool isActive;

  NotesModel(this.id, this.title, this.description, this.date, this.isActive);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title' :title,
      'description' :description,
      'date' :date,
      'isActive' :isActive,
    };
  }

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
        json['id'],
        json['title'],
        json['description'],
        json['date'],
        json['isActive']
    );
  }

}
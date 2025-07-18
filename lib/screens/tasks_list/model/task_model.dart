import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String categoryId;
  final String status;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.categoryId,
    required this.status,
  });

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) => TaskModel(
    id: id,
    title: map['title'],
    description: map['description'],
    dueDate: (map['dueDate'] as Timestamp).toDate(),
    categoryId: map['categoryId'],
    status: map['status'],
  );

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'dueDate': dueDate,
    'categoryId': categoryId,
    'status': status,
  };
}

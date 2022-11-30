import 'package:flutter/material.dart';

class TODO {
  String? id;
  String? todoText;
  bool isDone;

  TODO({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<TODO> todoList() {
    return [
      TODO(id:"1",todoText: "Learn Flutter Widget", isDone: false),
      TODO(id:"2",todoText: "Learn Flutter State", isDone: true),
      TODO(id:"3",todoText: "Learn Flutter Animation", isDone: false),
      TODO(id:"4",todoText: "Learn Flutter Color", isDone: true),
    ];
  }

}


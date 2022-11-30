import 'package:flutter/material.dart';

import '../model/todo.dart';

class List_Item extends StatelessWidget {
  List_Item({Key? key, required this.todo, required this.onItemStateChanged, required this.onItemDeletion}) : super(key: key);

  final TODO todo;
  final onItemStateChanged;
  final onItemDeletion;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ListTile(
        onTap: () {
          // change the state of list item
          onItemStateChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.black12,
        leading: Icon(
          todo.isDone? Icons.check_box:Icons.check_box_outline_blank,
          color: Colors.blueAccent,
        ),
        title: Text(
          todo.todoText!, // always add a ! when variable have ? sign
          style: todo.isDone? TextStyle(decoration: TextDecoration.lineThrough) : TextStyle(decoration: TextDecoration.none) ,
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
          child: IconButton(
            splashColor: Colors.redAccent.shade200,
            color: Colors.white,
            onPressed: () {
              onItemDeletion(todo.id);
            },
            icon: Icon(Icons.delete),
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}

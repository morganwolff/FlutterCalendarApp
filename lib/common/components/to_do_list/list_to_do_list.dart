import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/to_do_list/viewmodels/to_do_list_provider.dart';
import 'package:provider/provider.dart';

class ListToDoList extends StatefulWidget {
  const ListToDoList({super.key});

  @override
  State<ListToDoList> createState() => _ListToDoListState();
}

class _ListToDoListState extends State<ListToDoList> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ToDoListProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      ],
    );
  }
}
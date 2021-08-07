import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/widgets/todo_list_card.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List list = [
    "111",
    "222",
    "333",
    "444",
    "555",
    "111",
    "222",
    "333",
    "444",
    "555"
  ];
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> todoTaskStream = firestore
        .collection("ToDo Tasks")
        .orderBy("createdAt", descending: true)
        .snapshots();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: todoTaskStream,
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()!;
                      return TodoListCard(
                        value: data["task"],
                        id: document.id,
                        isComplete: data["isComplete"],
                      );
                    }).toList(),
                  );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  final TextEditingController addTaskController;
  final VoidCallback addTask;

  AddTask({required this.addTaskController, required this.addTask});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.only(left: 18),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextFormField(
              controller: addTaskController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Type Something here ...",
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: addTask,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            primary: Colors.black,
            elevation: 10,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}

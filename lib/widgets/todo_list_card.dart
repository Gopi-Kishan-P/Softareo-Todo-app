import 'package:flutter/material.dart';

class TodoListCard extends StatefulWidget {
  final String value;
  const TodoListCard({Key? key, required this.value}) : super(key: key);

  @override
  _TodoListCardState createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard> {
  bool isComplete = false;
  bool isEditable = false;
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  Color getColor() {
    return isComplete ? Colors.grey.shade600 : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        child: Row(
          children: [
            Checkbox(
                value: isComplete,
                shape: CircleBorder(),
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    this.isComplete = value!;
                  });
                }),
            Expanded(
              child: isEditable
                  ? TextFormField(
                      enabled: isEditable,
                      focusNode: focusNode,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      initialValue: widget.value,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    )
                  : Text(
                      widget.value,
                      style: TextStyle(
                          fontSize: 18,
                          color: getColor(),
                          decoration: isComplete
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
            ),
            IconButton(
              onPressed: () {
                focusNode.requestFocus();
                setState(() {
                  this.isEditable = !this.isEditable;
                });
              },
              icon: Icon(
                isEditable ? Icons.save_outlined : Icons.edit_outlined,
                color: getColor(),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline,
                color: getColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

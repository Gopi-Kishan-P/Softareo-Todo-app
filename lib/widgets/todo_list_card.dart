import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoListCard extends StatefulWidget {
  final String value;
  final String id;
  final bool isComplete;
  const TodoListCard({
    Key? key,
    required this.id,
    required this.value,
    required this.isComplete,
  }) : super(key: key);

  @override
  _TodoListCardState createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard> {
  bool isComplete = false;
  bool isEditable = false;
  late DocumentReference document;
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
    document =
        FirebaseFirestore.instance.collection("ToDo Tasks").doc(widget.id);
    TextEditingController _controller =
        TextEditingController(text: widget.value);
    isComplete = widget.isComplete;
    // print("Task : " + widget.value + ", Id : " + widget.id);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      elevation: 4,
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
                    document.update({"isComplete": value});
                  });
                }),
            Expanded(
              child: isEditable
                  ? TextFormField(
                      controller: _controller,
                      enabled: isEditable,
                      focusNode: focusNode,
                      style: TextStyle(fontSize: 18, color: Colors.black),
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
                if (!this.isEditable) {
                  focusNode.requestFocus();
                  setState(() {
                    this.isEditable = !this.isEditable;
                  });
                } else {
                  setState(() {
                    this.isEditable = !this.isEditable;
                  });
                  document.update({"task": _controller.text});
                }
              },
              icon: Icon(
                isEditable ? Icons.save_outlined : Icons.edit_outlined,
                color: getColor(),
              ),
            ),
            IconButton(
              onPressed: () {
                document.delete();
              },
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
